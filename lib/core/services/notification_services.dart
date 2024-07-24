
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freedom_chat_app/core/di/dependancy_injection.dart';
import 'package:freedom_chat_app/core/routes/routes.dart';
import 'package:freedom_chat_app/core/utils/app_secured.dart';
import 'package:freedom_chat_app/freedom.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';
import 'package:http/http.dart' as http;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.notification!.title}');
  getIt<LocalNotificationServices>().showNotification(
    title: message.notification!.title!,
    body: message.notification!.body!,
    senderId: message.data['senderId'],
    user: UserModel.fromJson(jsonDecode(message.data['user'])),
  );
  String senderId = message.data['senderId'];
  navigatorKey.currentState?.pushNamed(Routes.chatPage, arguments: senderId);
}

class RemoteNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final FirebaseMessaging firebaseMessaging;

  final FirebaseFirestore firebaseFireStore;
  final FirebaseAuth firebaseAuth;

  RemoteNotificationService(this.flutterLocalNotificationsPlugin,
      this.firebaseMessaging, this.firebaseFireStore, this.firebaseAuth);

  void firebaseNotification() {
    print('firebaseNotification');

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message notification: ${message.notification}');
        final notification = message.notification;
        getIt<LocalNotificationServices>().showNotification(
          title: notification!.title!,
          body: notification.body!,
          senderId: message.data['senderId'],
          user: UserModel.fromJson(jsonDecode(message.data['user'])),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('Message clicked!');
      String senderId = message.data['senderId'];
      navigatorKey.currentState?.pushNamed(Routes.chatPage, arguments: senderId);
    });
  }

  Future<void> requestPermission() async {
    final settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  Future<void> getToken() async {
    final token = await firebaseMessaging.getToken();
    _saveToken(token!);
  }

  Future<void> _saveToken(String token) async {
    await firebaseFireStore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(
      {'token': token},
      SetOptions(merge: true),
    ); //replace token each time we login
  }

  Future<String> getReceiverToken(String receiverId) async {
    final getToken =
    await firebaseFireStore.collection('users').doc(receiverId).get();
    return await getToken.data()!['token'];
  }

  Future<void> sendNotification({
    required String body,
    required String senderId,
    required String receiverToken,
    required String title,
    required UserModel user,

  }) async {
    try {
      const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

      print('Receiver Token: $receiverToken');

      final Map<String, dynamic> payload = {
        'to': receiverToken,
        'priority': 'high',
        "notification": {
          "title": title,
          "body": body,
          "mutable_content": true,
          "sound": "Tri-tone"
        },
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'status': 'done',
          'senderId': senderId,
          'user': user.toJson().map((key, value) => MapEntry(key, value is Timestamp ? value.toDate().toIso8601String() : value)),
        },
      };

      final http.Response response = await http.post(
        Uri.parse(fcmUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${AppSecured.appMessaging}',
        },
        body: jsonEncode(payload),
      );

      // Debug log to check the HTTP response status code
      print('FCM Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Notification sent successfully!');
      } else {
        print(
            'Failed to send notification. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}

class LocalNotificationServices {
  final FlutterLocalNotificationsPlugin notificationsPlugin;

  LocalNotificationServices({required this.notificationsPlugin});

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('logo_dark_freedom');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
          if (notificationResponse.payload != null) {
            print('Payload: ${notificationResponse.payload}');
            String senderId = jsonDecode(notificationResponse.payload!)['senderId'];
            Map<String, dynamic> user = jsonDecode(notificationResponse.payload!)['user'];
            navigatorKey.currentState?.pushNamed(Routes.chatPage, arguments: {
              'senderId': senderId,
              'user': UserModel.fromJson(user),
            });
          }
        });
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad,String ? senderId,required UserModel user}) async {
    String payload = jsonEncode({
      'senderId': senderId,
      'user': user.toJson().map((key, value) => MapEntry(key, value is Timestamp ? value.toDate().toIso8601String() : value)),
    });
    return notificationsPlugin.show(
        id, title, body, await notificationDetails(),payload: payload);
  }
}


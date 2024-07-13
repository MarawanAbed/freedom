
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freedom_chat_app/core/di/dependancy_injection.dart';
import 'package:http/http.dart' as http;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.notification!.title}');
  getIt<LocalNotificationsServices>().showNotification(
    title: message.notification!.title!,
    body: message.notification!.body!,
  );
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

      // if (message.notification != null) {
      //   print('Message notification: ${message.notification}');
      //   final notification = message.notification;
      //   getIt<LocalNotificationsServices>().showText(
      //     title: notification!.title!,
      //     body: notification.body!,
      //     fln: flutterLocalNotificationsPlugin,
      //   );
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('Message clicked!');
      // final receiverId = message.data['receiverId'];
      // final userSnapshot = await FirebaseFirestore.instance.collection('users').doc(receiverId).get();
      // final user = UserModel.fromJson(userSnapshot.data()!);
      // Navigators.navigationKey.currentState!.push(MaterialPageRoute(builder: (context) => ChatScreen(user: user)));
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
        },
      };

      final http.Response response = await http.post(
        Uri.parse(fcmUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // 'Authorization': 'key=${AppSecured.serverKey}',
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

class LocalNotificationsServices {
  final FlutterLocalNotificationsPlugin notificationsPlugin;

  LocalNotificationsServices({required this.notificationsPlugin});

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('icon');

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
            // final payloadData = jsonDecode(notificationResponse.payload!);
            // List<String> keywords = ['is about to end.', 'is about to start.'];
            // // Filter the title
            // String filteredTitle = HelperMethods().filterTitle(payloadData['title'], keywords);
            //
            // String body = payloadData['body'];
            // String startTime = payloadData['formattedStartTime'];
            // String endTime = payloadData['formattedEndTime'];
            //
            // navigatorKey.currentState?.push(MaterialPageRoute(
            //   builder: (context) =>
            //       NotificationPage(
            //         title: filteredTitle, // Use the filtered title
            //         body: body,
            //         startTime: startTime,
            //         endTime: endTime,
            //       ),
            // ));
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
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future<void> cancelNotification(int id) async {
    print('cancelNotification $id');
    await notificationsPlugin.cancel(id);
    print('cancelNotification done $id');
  }

  Future<void> cancelAllNotifications() async {
    await notificationsPlugin.cancelAll();
  }

}


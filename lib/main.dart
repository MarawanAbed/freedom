import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/core/di/dependancy_injection.dart';
import 'package:freedom_chat_app/core/helpers/cache.dart';
import 'package:freedom_chat_app/core/services/bloc_observer.dart';
import 'package:freedom_chat_app/core/services/notification_services.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/firebase_options.dart';
import 'package:freedom_chat_app/freedom.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  await setupGetIt();
  await getIt<LocalNotificationServices>().initNotification();
  getIt<RemoteNotificationService>().firebaseNotification();
  Bloc.observer = MyBlocObserver();
  bool? isOnBoarding = await getIt<SharedPreCacheHelper>().getData(key:AppStrings.onBoardingKey) ?? false;
  runApp( Freedom(
    isOnBoarding: isOnBoarding!,
  ));
}


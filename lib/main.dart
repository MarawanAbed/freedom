import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/core/di/dependancy_injection.dart';
import 'package:freedom_chat_app/core/helpers/cache.dart';
import 'package:freedom_chat_app/core/services/bloc_observer.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/freedom.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  Bloc.observer = MyBlocObserver();
  bool? isOnBoarding = await getIt<SharedPreCacheHelper>().getData(key:AppStrings.onBoardingKey) ?? false;
  runApp( Freedom(
    isOnBoarding: isOnBoarding!,
  ));
}


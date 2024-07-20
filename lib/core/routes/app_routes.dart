import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/core/di/dependancy_injection.dart';
import 'package:freedom_chat_app/core/routes/routes.dart';
import 'package:freedom_chat_app/freedom/auth/presentation/pages/auth_page.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/pages/chat_page.dart';
import 'package:freedom_chat_app/freedom/edit_profile/presentation/pages/edit_profile_page.dart';
import 'package:freedom_chat_app/freedom/home_layout/presentation/pages/home_layout.dart';
import 'package:freedom_chat_app/freedom/onBoarding/presentation/pages/on_boarding_page.dart';
import 'package:freedom_chat_app/freedom/search/presentation/pages/search_page.dart';
import 'package:freedom_chat_app/freedom/sign_in/presentation/bloc/sign_in_cubit.dart';
import 'package:freedom_chat_app/freedom/sign_in/presentation/pages/sign_in_page.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/pages/complete_your_sign_up_page.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/pages/sign_up_page.dart';
import 'package:freedom_chat_app/freedom/verify_email/presentation/pages/verify_email_page.dart';

class AppRoutes {
  static final routes = <String, Widget Function(BuildContext)>{
    Routes.onBoardingPage: (context) => const OnBoardingPage(),
    Routes.authPage: (context) => const AuthPage(),
    Routes.signInPage: (context) => BlocProvider(
          create: (context) => getIt<SignInCubit>(),
          child: const SignInPage(),
        ),
    Routes.signUpPage: (context) => const SignUpPage(),
    Routes.completeYourSignUpPage: (context) => const CompleteYourSignUpPage(),
    Routes.verifyEmailPage: (context) => const VerifyEmailPage(),
    Routes.homeLayout: (context) => const HomeLayout(),
    Routes.chatPage: (context) => const ChatPage(),
    Routes.searchPage: (context) => const SearchPage(),
    Routes.editProfilePage: (context) => const EditProfilePage(),
  };
}

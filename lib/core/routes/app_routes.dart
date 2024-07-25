import 'package:freedom_chat_app/freedom/sign_in/presentation/bloc/sign_in_cubit.dart';
import 'package:freedom_chat_app/freedom/search/presentation/bloc/search_users_cubit.dart';
import 'package:freedom_chat_app/freedom/profile/presentation/bloc/get_user_cubit.dart';
import 'package:freedom_chat_app/freedom/home/presentation/bloc/home_cubit.dart';
import 'package:freedom_chat_app/freedom/forget_password/presentation/bloc/forget_password_cubit.dart';
import 'package:freedom_chat_app/freedom/edit_profile/presentation/bloc/update_profile_cubit.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/bloc/send_messages_cubit.dart';
import 'package:freedom_chat_app/lib_imports.dart';

class AppRoutes {
  static final routes = <String, Widget Function(BuildContext)>{
    Routes.onBoardingPage: (context) => const OnBoardingPage(),
    Routes.authPage: (context) => const AuthPage(),
    Routes.signInPage: (context) => BlocProvider(
          create: (context) => getIt<SignInCubit>(),
          child: const SignInPage(),
        ),
    Routes.forgotPasswordPage: (context) => BlocProvider(
          create: (context) => getIt<ForgetPasswordCubit>(),
          child: const ForgetPasswordPage(),
        ),
    Routes.signUpPage: (context) => const SignUpPage(),
    Routes.completeYourSignUpPage: (context) => const CompleteYourSignUpPage(),
    Routes.verifyEmailPage: (context) => const VerifyEmailPage(),
    Routes.homeLayout: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<HomeCubit>()..getAllUsers(),
            ),
            BlocProvider(
              create: (context) => getIt<GetUserCubit>(),
            ),
          ],
          child: const HomeLayout(),
        ),
    Routes.chatPage: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<SendMessagesCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<GetAllMessagesCubit>(),
            ),
          ],
          child: const ChatPage(),
        ),
    Routes.editProfilePage: (context) => BlocProvider(
          create: (context) => getIt<UpdateProfileCubit>(),
          child: const EditProfilePage(),
        ),
    Routes.searchPage: (context) => BlocProvider(
          create: (context) => getIt<SearchUsersCubit>(),
          child: const SearchPage(),
        ),
  };
}

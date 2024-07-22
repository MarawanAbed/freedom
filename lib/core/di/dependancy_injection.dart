import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freedom_chat_app/core/helpers/cache.dart';
import 'package:freedom_chat_app/core/services/firebase_services.dart';
import 'package:freedom_chat_app/core/services/notification_services.dart';
import 'package:freedom_chat_app/core/utils/app_secured.dart';
import 'package:freedom_chat_app/freedom/chat/domain/use_cases/send_message.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/bloc/get_all_messages_cubit.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/bloc/send_messages_cubit.dart';
import 'package:freedom_chat_app/freedom/edit_profile/domain/use_cases/update_profile.dart';
import 'package:freedom_chat_app/freedom/forget_password/data/data_sources/remote_data_Source.dart';
import 'package:freedom_chat_app/freedom/forget_password/data/repositories/repo_impl.dart';
import 'package:freedom_chat_app/freedom/forget_password/domain/repositories/repo.dart';
import 'package:freedom_chat_app/freedom/forget_password/domain/use_cases/forget_password.dart';
import 'package:freedom_chat_app/freedom/forget_password/presentation/bloc/forget_password_cubit.dart';
import 'package:freedom_chat_app/freedom/home/data/data_sources/remote_data_source.dart';
import 'package:freedom_chat_app/freedom/home/data/repositories/repo_impl.dart';
import 'package:freedom_chat_app/freedom/home/domain/repositories/repo.dart';
import 'package:freedom_chat_app/freedom/home/domain/use_case/update_user.dart';
import 'package:freedom_chat_app/freedom/home/presentation/bloc/home_cubit.dart';
import 'package:freedom_chat_app/freedom/home_layout/data/data_source/remote_data_source.dart';
import 'package:freedom_chat_app/freedom/home_layout/data/repo/repo_impl.dart';
import 'package:freedom_chat_app/freedom/home_layout/domain/repo/repo.dart';
import 'package:freedom_chat_app/freedom/profile/data/data_sources/remote_data_source.dart';
import 'package:freedom_chat_app/freedom/profile/data/repositories/repo_impl.dart';
import 'package:freedom_chat_app/freedom/profile/domain/repositories/repo.dart';
import 'package:freedom_chat_app/freedom/profile/presentation/bloc/get_user_cubit.dart';
import 'package:freedom_chat_app/freedom/search/domain/use_cases/search_users.dart';
import 'package:freedom_chat_app/freedom/sign_in/data/data_sources/remote_data_source.dart';
import 'package:freedom_chat_app/freedom/sign_in/data/repositories/repo_impl.dart';
import 'package:freedom_chat_app/freedom/sign_in/domain/repositories/repo.dart';
import 'package:freedom_chat_app/freedom/sign_in/domain/use_cases/sign_in_with_email_and_password.dart';
import 'package:freedom_chat_app/freedom/sign_in/domain/use_cases/sign_in_with_github.dart';
import 'package:freedom_chat_app/freedom/sign_in/domain/use_cases/sign_in_with_google.dart';
import 'package:freedom_chat_app/freedom/sign_in/domain/use_cases/sign_in_with_twitter.dart';
import 'package:freedom_chat_app/freedom/sign_in/presentation/bloc/sign_in_cubit.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/data_sources/remote_data_source.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/repositories/repo_impl.dart';
import 'package:freedom_chat_app/freedom/sign_up/domain/repositories/repo.dart';
import 'package:freedom_chat_app/freedom/sign_up/domain/use_cases/sign_up.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:freedom_chat_app/freedom/verify_email/data/data_sources/remote_data_source.dart';
import 'package:freedom_chat_app/freedom/verify_email/data/repositories/repo_impl.dart';
import 'package:freedom_chat_app/freedom/verify_email/domain/repositories/repo.dart';
import 'package:freedom_chat_app/freedom/verify_email/domain/use_cases/send_email_verification.dart';
import 'package:freedom_chat_app/freedom/verify_email/domain/use_cases/sign_out.dart';
import 'package:get_it/get_it.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_login/twitter_login.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  try {
    getIt.registerLazySingleton<SharedPreCacheHelper>(
        () => SharedPreCacheHelper(getIt<SharedPreferences>()));
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
    _setupDataSources();
    _setupRepositories();
    _setupUseCases();
    _setupCubits();
    _setupServices();
    _setupExternal();
  } catch (e) {
    print('Failed to initialize dependencies: $e');
  }
}

void _setupDataSources() {
  // //data sources
  // getIt.registerLazySingleton<ChatRemoteDataSource>(
  //         () => ChatRemoteDataSourceImpl(
  //       databaseService: getIt(),
  //       storeService: getIt(),
  //       authService: getIt(),
  //     ));
  getIt.registerLazySingleton<SignInRemoteDataSource>(
      () => SignInRemoteDataSourceImpl(authService: getIt()));
  getIt.registerLazySingleton<ForgetPasswordRemoteDataSource>(
      () => ForgetPasswordRemoteDataSourceImpl(auth: getIt()));
  getIt.registerLazySingleton<VerifyRemoteDataSource>(
      () => VerifyRemoteDataSourceImpl(authService: getIt()));
  getIt.registerLazySingleton<SignUpRemoteDataSource>(
      () => SignUpRemoteDataSourceImpl(
            authService: getIt(),
            storageService: getIt(),
            databaseService: getIt(),
          ));
  getIt.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(service: getIt(), authService: getIt()));
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(profileService: getIt()));
  getIt.registerLazySingleton<HomeLayoutRemoteDataSource>(
      () => HomeLayoutRemoteDataSourceImpl(auth: getIt()));
  // getIt.registerLazySingleton<ChatRemoteDataSource>(
  //       () => ChatRemoteDataSourceImpl(getIt(), getIt(), getIt()),
  // );
}

void _setupRepositories() {
  getIt.registerLazySingleton<SignInRepo>(
      () => SignInRepoImpl(signInRemoteDataSource: getIt()));
  getIt.registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(homeDataSource: getIt()));
  getIt.registerLazySingleton<ForgetPasswordRepo>(
      () => ForgetPasswordRepoImpl(dataSource: getIt()));
  getIt.registerLazySingleton<SignUpRepository>(
      () => SignUpRepositoryImpl(repo: getIt()));
  getIt
      .registerLazySingleton<HomeLayoutRepo>(() => HomeLayoutRepoImpl(getIt()));
  getIt.registerLazySingleton<VerifyRepository>(
      () => VerifyRepoImpl(verifyDataSource: getIt()));
  getIt.registerLazySingleton<ProfileRepo>(
      () => ProfileRepoImpl(profileDataSource: getIt()));
}

void _setupUseCases() {
  getIt.registerLazySingleton<SendEmailVerificationUseCase>(
      () => SendEmailVerificationUseCase(repo: getIt()));
  getIt.registerLazySingleton<UpdateUserUseCase>(
      () => UpdateUserUseCase(repo: getIt()));
  getIt.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repo: getIt()));
  getIt.registerLazySingleton<ForgetPasswordUseCase>(
      () => ForgetPasswordUseCase(repo: getIt()));
  getIt
      .registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(repo: getIt()));
  getIt.registerLazySingleton<SignInWithEmailAndPasswordUseCase>(
      () => SignInWithEmailAndPasswordUseCase(repo: getIt()));
  getIt.registerLazySingleton<SignInWithTwitterUseCase>(
      () => SignInWithTwitterUseCase(repo: getIt()));
  getIt.registerLazySingleton<SignInWithGoogleUseCase>(
      () => SignInWithGoogleUseCase(repo: getIt()));
  getIt.registerLazySingleton<SignInWithGithubUseCase>(
      () => SignInWithGithubUseCase(repo: getIt()));
  getIt.registerLazySingleton<SearchUsersUseCase>(
      () => SearchUsersUseCase(repo: getIt()));
  getIt.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(repo: getIt()));
  getIt.registerLazySingleton<SendMessageUseCase>(() => SendMessageUseCase());
}

void _setupCubits() {
  getIt.registerFactory<SignInCubit>(
    () => SignInCubit(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );

  getIt.registerFactory<SendMessagesCubit>(
    () => SendMessagesCubit(),
  );
  getIt.registerFactory<GetAllMessagesCubit>(
    () => GetAllMessagesCubit(),
  );
  getIt.registerFactory<ForgetPasswordCubit>(
    () => ForgetPasswordCubit(
      getIt(),
    ),
  );
  // getIt.registerFactory<UpdateUserCubit>(
  //   () => UpdateUserCubit(
  //     getIt(),
  //     getIt(),
  //     getIt(),
  //     getIt(),
  //   ),
  // );
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      getIt(),
    ),
  );
  getIt.registerFactory<GetUserCubit>(
    () => GetUserCubit(
      getIt(),
    ),
  );
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(
        getIt(),
        getIt(),
      ));
  // getIt.registerFactory<ForgetPasswordCubit>(
  //   () => ForgetPasswordCubit(
  //     getIt(),
  //   ),
  // );
  //
  // getIt.registerFactory<VerifyEmailCubit>(
  //   () => VerifyEmailCubit(
  //     checkVerifyEmail: getIt(),
  //     verifyEmail: getIt(),
  //     resendVerifyEmail: getIt(),
  //     logOut: getIt(),
  //   ),
  // );
  //
  // getIt.registerFactory<SearchUsersCubit>(
  //   () => SearchUsersCubit(
  //     getIt(),
  //   ),
  // );
}

void _setupServices() {
  getIt.registerLazySingleton<AuthService>(() => AuthService(
        googleSignIn: getIt(),
        auth: getIt(),
        gitHubSignIn: getIt(),
        twitterLogin: getIt(),
      ));
  getIt.registerLazySingleton<StorageService>(() => StorageService(
        getIt(),
      ));
  getIt.registerLazySingleton<DatabaseService>(() => DatabaseService(
        getIt(),
      ));
  getIt.registerLazySingleton<RemoteNotificationService>(
      () => RemoteNotificationService(
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ));
  getIt.registerLazySingleton<LocalNotificationsServices>(
      () => LocalNotificationsServices(
            notificationsPlugin: getIt(),
          ));
}

void _setupExternal() {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  final GitHubSignIn gitHubSignIn = GitHubSignIn(
    clientId: AppSecured.gitHubClientId,
    clientSecret: AppSecured.gitHubClientSecret,
    redirectUrl: 'https://notes-firebase-f2d88.firebaseapp.com/__/auth/handler',
  );
  final twitterLogin = TwitterLogin(
      apiKey: AppSecured.twitterApiKey,
      apiSecretKey: AppSecured.twitterApiSecret,
      redirectURI: 'flutter-twitter-practice://');
  final storage = FirebaseStorage.instance;
  final fireStore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final messaging = FirebaseMessaging.instance;
  getIt.registerLazySingleton(() => auth);
  getIt.registerLazySingleton(() => messaging);
  getIt.registerLazySingleton(() => flutterLocalNotificationsPlugin);
  getIt.registerLazySingleton(() => fireStore);
  getIt.registerLazySingleton(() => storage);
  getIt.registerLazySingleton(() => googleSignIn);
  getIt.registerLazySingleton(() => gitHubSignIn);
  getIt.registerLazySingleton(() => twitterLogin);
}

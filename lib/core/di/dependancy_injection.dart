import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freedom_chat_app/core/helpers/cache.dart';
import 'package:freedom_chat_app/core/services/firebase_services.dart';
import 'package:freedom_chat_app/core/services/notification_services.dart';
import 'package:get_it/get_it.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_login/twitter_login.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  try
  {
    getIt.registerLazySingleton<SharedPreCacheHelper>(
            () => SharedPreCacheHelper(getIt<SharedPreferences>()));
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
    // _setupDataSources();
    // _setupRepositories();
    // _setupUseCases();
    // _setupCubits();
    _setupServices();
    _setupExternal();
  }catch(e)
  {
    print('Failed to initialize dependencies: $e');
  }
}

// void _setupDataSources() {
//   //data sources
//   getIt.registerLazySingleton<HomeRemoteDataSource>(
//           () => HomeRemoteDataSourceImpl(
//         databaseService: getIt(),
//         storeService: getIt(),
//         authService: getIt(),
//       ));
//   getIt.registerLazySingleton<LoginRemoteDataSource>(
//           () => LoginRemoteDataSourceImpl(getIt()));
//   getIt.registerLazySingleton<VerifyEmailRemoteDataSource>(
//           () => VerifyEmailRemoteDataSourceImpl(getIt()));
//   getIt.registerLazySingleton<RegisterRemoteDataSource>(
//           () => RegisterRemoteDataSourceImpl(
//         auth: getIt(),
//         storage: getIt(),
//         databaseService: getIt(),
//       ));
//   getIt.registerLazySingleton<ForgetRemoteDataSource>(
//           () => ForgetRemoteDataSourceImpl(auth: getIt()));
//   getIt.registerLazySingleton<ChatRemoteDataSource>(
//         () => ChatRemoteDataSourceImpl(getIt(), getIt(), getIt()),
//   );
// }
//
// void _setupRepositories()
// {
//   getIt.registerLazySingleton<ChatRepo>(() => ChatRepoImpl((getIt())));
//   getIt.registerLazySingleton<HomeRepo>(() => HomeRepoImpl((getIt())));
//   getIt.registerLazySingleton<LoginInRepo>(() => LoginRepoImpl(getIt()));
//   getIt.registerLazySingleton<RegisterRepo>(() => RegisterRepoImpl(getIt()));
//   getIt.registerLazySingleton<ForgetRepo>(() => ForgetRepoImpl(getIt()));
//   getIt.registerLazySingleton<VerifyEmailRepo>(
//           () => VerifyEmailRepoImpl(getIt()));
// }
//
// void _setupUseCases()
// {
//   getIt.registerLazySingleton<GetAllUsersUseCase>(
//           () => GetAllUsersUseCase(getIt()));
//   getIt.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(getIt()));
//   getIt.registerLazySingleton<UpdateUserUseCase>(
//           () => UpdateUserUseCase(getIt()));
//   getIt.registerLazySingleton<UpdateEmailAndPasswordUseCase>(
//           () => UpdateEmailAndPasswordUseCase(getIt()));
//
//   getIt.registerLazySingleton<CheckVerifyEmailUseCase>(
//           () => CheckVerifyEmailUseCase(getIt()));
//   getIt.registerLazySingleton<SignInUseCase>(() => SignInUseCase(getIt()));
//   getIt.registerLazySingleton<UserUidUseCase>(() => UserUidUseCase(getIt()));
//   getIt.registerLazySingleton<ForgetPasswordUseCase>(
//           () => ForgetPasswordUseCase(getIt()));
//   getIt.registerLazySingleton<HomeLogOutUseCase>(
//           () => HomeLogOutUseCase(getIt()));
//   getIt.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(getIt()));
//   getIt.registerLazySingleton<RegisterUploadImageUseCase>(
//           () => RegisterUploadImageUseCase(getIt()));
//   getIt.registerLazySingleton<UploadImageUseCase>(
//           () => UploadImageUseCase(getIt()));
//   getIt.registerLazySingleton<GoogleSignInUseCase>(
//           () => GoogleSignInUseCase(getIt()));
//   getIt.registerLazySingleton<GitHubSignInUseCase>(
//           () => GitHubSignInUseCase(getIt()));
//   getIt.registerLazySingleton<TwitterSignInUseCase>(
//           () => TwitterSignInUseCase(getIt()));
//   getIt.registerLazySingleton<CreateUserUseCase>(
//           () => CreateUserUseCase(getIt()));
//   getIt.registerLazySingleton<VerifyEmailUseCase>(
//           () => VerifyEmailUseCase(getIt()));
//   getIt.registerLazySingleton<LogOutUseCase>(() => LogOutUseCase(getIt()));
//   getIt.registerLazySingleton<ResendVerifyEmailUseCase>(
//           () => ResendVerifyEmailUseCase(getIt()));
//   getIt.registerLazySingleton<SearchUsersUseCase>(
//           () => SearchUsersUseCase(getIt()));
//   getIt.registerLazySingleton<ChatsUploadImageUseCase>(
//           () => ChatsUploadImageUseCase(getIt()));
//   getIt.registerLazySingleton<AddImageMessageUseCase>(
//           () => AddImageMessageUseCase(getIt()));
//   getIt.registerLazySingleton<AddTextMessageUseCase>(
//           () => AddTextMessageUseCase(getIt()));
//   getIt.registerLazySingleton<GetAllMessagesUseCase>(
//           () => GetAllMessagesUseCase(getIt()));
//   getIt
//       .registerLazySingleton<GetUserIdUseCase>(() => GetUserIdUseCase(getIt()));
//
// }
//
// void _setupCubits()
// {
//   getIt.registerFactory<LoginCubit>(
//         () => LoginCubit(
//       twitterSignInUseCase: getIt(),
//       googleSignInUseCase: getIt(),
//       signInUseCase: getIt(),
//       gitHubSignInUseCase: getIt(),
//     ),
//   );
//
//   getIt.registerFactory<SendMessagesCubit>(
//         () => SendMessagesCubit(
//       getIt(),
//       getIt(),
//       getIt(),
//       getIt(),
//     ),
//   );
//   getIt.registerFactory<GetAllMessagesCubit>(
//         () => GetAllMessagesCubit(
//       getIt(),
//     ),
//   );
//   getIt.registerFactory<UpdateUserCubit>(
//         () => UpdateUserCubit(
//       getIt(),
//       getIt(),
//       getIt(),
//       getIt(),
//     ),
//   );
//   getIt.registerFactory<GetAllUserCubit>(
//         () => GetAllUserCubit(
//       getIt(),
//       getIt(),
//     ),
//   );
//   getIt.registerFactory<GetUserCubit>(
//         () => GetUserCubit(
//       getIt(),
//       getIt(),
//     ),
//   );
//   getIt.registerFactory<RegisterCubit>(() => RegisterCubit(
//     registerUseCase: getIt(),
//     uploadImageUseCase: getIt(),
//     createUserUseCase: getIt(),
//   ));
//   getIt.registerFactory<ForgetPasswordCubit>(
//         () => ForgetPasswordCubit(
//       getIt(),
//     ),
//   );
//
//   getIt.registerFactory<VerifyEmailCubit>(
//         () => VerifyEmailCubit(
//       checkVerifyEmail: getIt(),
//       verifyEmail: getIt(),
//       resendVerifyEmail: getIt(),
//       logOut: getIt(),
//     ),
//   );
//
//   getIt.registerFactory<SearchUsersCubit>(
//         () => SearchUsersCubit(
//       getIt(),
//     ),
//   );
//
// }

void _setupServices()
{
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
        notificationsPlugin:  getIt(),
      ));
}

void _setupExternal()
{
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  final GitHubSignIn gitHubSignIn = GitHubSignIn(
    clientId: '',
    clientSecret:'',
    redirectUrl: '',
  );
  final twitterLogin = TwitterLogin(
      apiKey: 'AppSecured.twitterApiKey',
      apiSecretKey: 'AppSecured.twitterApiSecretKey',
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

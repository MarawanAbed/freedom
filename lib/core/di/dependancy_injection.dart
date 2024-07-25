import 'package:freedom_chat_app/lib_imports.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/bloc/send_messages_cubit.dart';
import 'package:freedom_chat_app/freedom/edit_profile/presentation/bloc/update_profile_cubit.dart';
import 'package:freedom_chat_app/freedom/forget_password/presentation/bloc/forget_password_cubit.dart';
import 'package:freedom_chat_app/freedom/home/presentation/bloc/home_cubit.dart';
import 'package:freedom_chat_app/freedom/profile/presentation/bloc/get_user_cubit.dart';
import 'package:freedom_chat_app/freedom/search/presentation/bloc/search_users_cubit.dart';
import 'package:freedom_chat_app/freedom/sign_in/presentation/bloc/sign_in_cubit.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/bloc/sign_up_cubit.dart';

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
  getIt.registerLazySingleton<ChatRemoteDataSource>(
          () => ChatRemoteDataSourceImpl(
        databaseService: getIt(),
        storageService: getIt(),
      ));
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
  getIt.registerLazySingleton<EditProfileRemoteDataSource>(
          () => EditProfileRemoteDataSourceImpl(service: getIt(), storageService: getIt()));
  getIt.registerLazySingleton<SearchRemoteDataSource>(
        () => SearchRemoteDataSourceImpl(searchService:getIt()),
  );
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
  getIt.registerLazySingleton<SearchRepo>(
          () => SearchRepositoryImpl(searchDataSource: getIt()));
  getIt
      .registerLazySingleton<HomeLayoutRepo>(() => HomeLayoutRepoImpl(getIt()));
  getIt.registerLazySingleton<VerifyRepository>(
      () => VerifyRepoImpl(verifyDataSource: getIt()));
  getIt.registerLazySingleton<ProfileRepo>(
      () => ProfileRepoImpl(profileDataSource: getIt()));
  getIt.registerLazySingleton<EditProfileRepo>(
          () => EditProfileRepositoryImpl(dataSource: getIt()));

  getIt.registerLazySingleton<ChatRepo>(
          () => ChatRepoImpl(dataSource: getIt()));
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
  getIt.registerLazySingleton<SendMessageUseCase>(() => SendMessageUseCase(
    chatRepo: getIt(),
  ));
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
    () => SendMessagesCubit(
      getIt(),
      getIt(),
    ),
  );
  getIt.registerFactory<GetAllMessagesCubit>(
    () => GetAllMessagesCubit(
      getIt(),
    ),
  );
  getIt.registerFactory<ForgetPasswordCubit>(
    () => ForgetPasswordCubit(
      getIt(),
    ),
  );
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
  getIt.registerFactory<UpdateProfileCubit>(
        () => UpdateProfileCubit(
      getIt(),
      getIt(),
        ),
  );
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(
        getIt(),
        getIt(),
      ));
  getIt.registerFactory<SearchUsersCubit>(
    () => SearchUsersCubit(
      getIt(),
    ),
  );
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
  getIt.registerLazySingleton<LocalNotificationServices>(
      () => LocalNotificationServices(
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

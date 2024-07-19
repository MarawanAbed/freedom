import 'package:freedom_chat_app/core/services/firebase_services.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Stream<UserModel>getUser();
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final DatabaseService _profileService;

  ProfileRemoteDataSourceImpl({required DatabaseService profileService})
      : _profileService = profileService;

  @override
  Stream<UserModel> getUser() {
    return _profileService.getSingleUser();
  }
}
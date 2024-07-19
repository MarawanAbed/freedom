import 'dart:io';

import 'package:freedom_chat_app/core/services/firebase_services.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

abstract class SignUpRemoteDataSource {
  Future<void> signUp(UserModel user);

  Future<String> uploadImage(File imageFile);

  Future<void> createUser(UserModel user);
}

class SignUpRemoteDataSourceImpl extends SignUpRemoteDataSource {
  final AuthService _authService;
  final StorageService _storageService;
  final DatabaseService _databaseService;

  SignUpRemoteDataSourceImpl({required AuthService authService,
    required StorageService storageService,
    required DatabaseService databaseService })
      : _authService = authService,
        _storageService = storageService,
        _databaseService=databaseService;

  @override
  Future<void> createUser(UserModel user) async {
    await _databaseService.createUser(user);
  }

  @override
  Future<void> signUp(UserModel user) async{
   await _authService.signUp(email: user.email!, password: user.password!);
  }

  @override
  Future<String> uploadImage(File imageFile)async {
    return await _storageService.uploadImage(imageFile);
  }
}

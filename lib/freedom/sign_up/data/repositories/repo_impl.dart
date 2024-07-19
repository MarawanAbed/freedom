import 'dart:io';

import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';
import 'package:freedom_chat_app/freedom/sign_up/domain/repositories/repo.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpRepository _repo;

  SignUpRepositoryImpl({required SignUpRepository repo}) : _repo = repo;

  @override
  Future<void> createUser(UserModel user)async {
    try
    {
      await _repo.createUser(user);
    }
    catch(e){
      print(e);
    }
  }

  @override
  Future<void> signUp(UserModel user)async {
    try
    {
      await _repo.signUp(user);
    }
    catch(e){
      print(e);
    }
  }

  @override
  Future<String> uploadImage(File imageFile)async {
    try
    {
      return await _repo.uploadImage(imageFile);
    }
    catch(e){
      print(e);
      return '';
  }
}
}

import 'dart:io';

import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

abstract class SignUpRepository {
  Future<void> signUp(UserModel user);

  Future<String> uploadImage(File imageFile);

  Future<void> createUser(UserModel user);
}
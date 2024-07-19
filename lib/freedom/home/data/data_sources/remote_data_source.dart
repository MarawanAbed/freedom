import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

abstract class HomeRemoteDataSource {
  Stream<List<UserModel>> getAllUsers();
}
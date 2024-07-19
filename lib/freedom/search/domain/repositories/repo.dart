import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

abstract class SearchRepo
{
  Stream<List<UserModel>> search(String query);
}
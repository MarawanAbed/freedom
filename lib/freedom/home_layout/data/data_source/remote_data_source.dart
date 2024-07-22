import 'package:freedom_chat_app/core/services/firebase_services.dart';

abstract class HomeLayoutRemoteDataSource
{
  Future<void>logout();
}

class HomeLayoutRemoteDataSourceImpl extends HomeLayoutRemoteDataSource
{
  final AuthService _auth;

  HomeLayoutRemoteDataSourceImpl({required AuthService auth}):_auth=auth;

  @override
  Future<void> logout() async
  {
    await _auth.signOut();
  }
}
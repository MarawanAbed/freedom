import 'package:freedom_chat_app/core/services/firebase_services.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

abstract class HomeRemoteDataSource {
  Stream<List<UserModel>> getAllUsers();
  Future<void>updateUser(Map<String,dynamic> user);
  String? getUid();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource
{
  final DatabaseService _service;
  final AuthService _authService;
  HomeRemoteDataSourceImpl({required DatabaseService service,required AuthService authService}) : _service = service,_authService=authService;

  @override
  Stream<List<UserModel>> getAllUsers() {
    return _service.getAllUsers();
  }

  @override
  Future<void> updateUser(Map<String,dynamic> user)async {
    await _service.updateUser(user);
  }

  @override
  String? getUid() {
    return _authService.getCurrentUserId();
  }

}
import 'package:freedom_chat_app/core/services/firebase_services.dart';

abstract class ForgetPasswordRemoteDataSource {
  Future<void> forgetPassword(String email);

}

class ForgetPasswordRemoteDataSourceImpl
    extends ForgetPasswordRemoteDataSource {
  final AuthService _auth;

  ForgetPasswordRemoteDataSourceImpl({required AuthService auth})
      : _auth = auth;

  @override
  Future<void> forgetPassword(String email) async {
    await _auth.forgetPassword(email);
  }
}

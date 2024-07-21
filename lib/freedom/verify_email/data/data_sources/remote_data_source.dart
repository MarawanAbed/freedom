import 'package:freedom_chat_app/core/services/firebase_services.dart';

abstract class VerifyRemoteDataSource
{
  Future<void> sendEmailVerification();
  Future<void> signOut();
  bool isEmailVerified();
  Future<void> reloadUser();
}

class VerifyRemoteDataSourceImpl extends VerifyRemoteDataSource
{
  final AuthService _authService;

  VerifyRemoteDataSourceImpl({required AuthService authService}):_authService=authService;

  @override
  bool isEmailVerified() {
    return _authService.emailVerified();
  }

  @override
  Future<void> reloadUser() async{
    await _authService.reloadUser();
  }

  @override
  Future<void> sendEmailVerification() async{
    await _authService.sendEmailVerification();
  }

  @override
  Future<void> signOut()async {
    await _authService.signOut();
  }


}
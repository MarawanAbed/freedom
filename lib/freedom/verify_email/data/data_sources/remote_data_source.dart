import 'package:freedom_chat_app/core/services/firebase_services.dart';

abstract class VerifyRemoteDataSource
{
  Future<void> sendVerificationEmail();

  Future<bool>isEmailVerified();

  bool userVerified();
}

class VerifyRemoteDataSourceImpl extends VerifyRemoteDataSource
{
  final AuthService _authService;

  VerifyRemoteDataSourceImpl({required AuthService authService}):_authService=authService;

  @override
  Future<void> sendVerificationEmail() async
  {
    await _authService.sendVerificationEmail();
  }

  @override
  Future<bool> isEmailVerified() async
  {
    return await _authService.isEmailVerified();
  }

  @override
  bool userVerified() {
    return _authService.userVerified();
  }
}
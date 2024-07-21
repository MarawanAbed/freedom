import 'package:firebase_auth/firebase_auth.dart';
import 'package:freedom_chat_app/core/di/dependancy_injection.dart';
import 'package:freedom_chat_app/core/services/firebase_services.dart';
import 'package:freedom_chat_app/freedom/verify_email/data/data_sources/remote_data_source.dart';
import 'package:freedom_chat_app/freedom/verify_email/domain/repositories/repo.dart';

class VerifyRepoImpl extends VerifyRepository {
  final VerifyRemoteDataSource _verifyDataSource;

  VerifyRepoImpl({required VerifyRemoteDataSource verifyDataSource})
      : _verifyDataSource = verifyDataSource;

  @override
  bool isEmailVerified()  {
    try {
      return  _verifyDataSource.isEmailVerified();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> reloadUser() async {
    User? user = getIt<AuthService>().auth.currentUser;
    if (user != null) {
      await user.reload();
    } else {
      throw Exception('No user is currently signed in.');
    }
  }

  @override
  Future<void> sendEmailVerification() async{
    try {
      await _verifyDataSource.sendEmailVerification();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> signOut() {
    try {
      return _verifyDataSource.signOut();
    } catch (e) {
      throw e;
    }
  }
}

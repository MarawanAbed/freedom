import 'package:freedom_chat_app/freedom/verify_email/domain/repositories/repo.dart';

class VerifyRepoImpl extends VerifyRepository {
  final VerifyRepository _verifyDataSource;

  VerifyRepoImpl({required VerifyRepository verifyDataSource})
      : _verifyDataSource = verifyDataSource;

  @override
  Future<bool> isEmailVerified()async {
    try
    {
      return await _verifyDataSource.isEmailVerified();
    }
    catch(e){
      print(e);
      return false;
    }
  }

  @override
  Future<void> sendVerificationEmail() async{
    try
    {
      await _verifyDataSource.sendVerificationEmail();
    }
    catch(e){
      print(e);
    }
  }

  @override
  bool userVerified() {
    return _verifyDataSource.userVerified();
  }


}
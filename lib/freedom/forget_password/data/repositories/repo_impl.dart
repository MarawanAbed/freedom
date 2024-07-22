import 'package:freedom_chat_app/freedom/forget_password/data/data_sources/remote_data_Source.dart';
import 'package:freedom_chat_app/freedom/forget_password/domain/repositories/repo.dart';

class ForgetPasswordRepoImpl extends ForgetPasswordRepo
{
  final ForgetPasswordRemoteDataSource _dataSource;

  ForgetPasswordRepoImpl({required ForgetPasswordRemoteDataSource dataSource}) : _dataSource = dataSource;

  @override
  Future<void> forgetPassword(String email) async{
    try
    {
      await _dataSource.forgetPassword(email);
    }
    catch(e)
    {
      throw e;
    }
  }

}
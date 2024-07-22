import 'package:freedom_chat_app/freedom/home_layout/data/data_source/remote_data_source.dart';
import 'package:freedom_chat_app/freedom/home_layout/domain/repo/repo.dart';

class HomeLayoutRepoImpl extends HomeLayoutRepo {
  final HomeLayoutRemoteDataSource _dataSource;

  HomeLayoutRepoImpl(this._dataSource);



  @override
  Future<void> logout() async{
    try
    {
      await _dataSource.logout();
    }
    catch(e)
    {
      throw e;
    }
  }
}
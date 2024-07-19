import 'package:freedom_chat_app/freedom/edit_profile/data/data_sources/remote_data_source.dart';
import 'package:freedom_chat_app/freedom/edit_profile/domain/repositories/repo.dart';

class EditProfileRepositoryImpl extends EditProfileRepo {
  final EditProfileRemoteDataSource _dataSource;

  EditProfileRepositoryImpl({required EditProfileRemoteDataSource dataSource}) : _dataSource = dataSource;




  @override
  Future<void> updateUser(Map<String, dynamic> data)async {
    try
    {
      await _dataSource.updateUser(data);
    }
    catch(e)
    {
      throw e;
    }
  }
}
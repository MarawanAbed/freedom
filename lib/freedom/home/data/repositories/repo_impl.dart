import 'package:freedom_chat_app/freedom/home/data/data_sources/remote_data_source.dart';
import 'package:freedom_chat_app/freedom/home/domain/repositories/repo.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

class HomeRepoImpl extends HomeRepo
{
  final HomeRemoteDataSource homeDataSource;

  HomeRepoImpl({required this.homeDataSource});

  @override
  Stream<List<UserModel>> getAllUsers() {
    try
    {
      return homeDataSource.getAllUsers();
    }
    catch(e)
    {
      throw e;
    }
  }
}
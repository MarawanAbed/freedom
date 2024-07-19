import 'package:freedom_chat_app/core/services/firebase_services.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

abstract class SearchRemoteDataSource {
  Stream<List<UserModel>> search(String query);
}


class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final DatabaseService _searchService;

  SearchRemoteDataSourceImpl({required DatabaseService searchService})
      : _searchService = searchService;

  @override
  Stream<List<UserModel>> search(String query)  {
    return _searchService.searchUsers(name: query);
  }
}
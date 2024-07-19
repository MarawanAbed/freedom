import 'package:freedom_chat_app/freedom/search/data/data_sources/remote_data_source.dart';
import 'package:freedom_chat_app/freedom/search/domain/repositories/repo.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

class SearchRepositoryImpl implements SearchRepo {
  final SearchRemoteDataSource _searchDataSource;

  SearchRepositoryImpl({required SearchRemoteDataSource searchDataSource})
      : _searchDataSource = searchDataSource;

  @override
  Stream<List<UserModel>> search(String query) {
    return _searchDataSource.search(query);
  }
}

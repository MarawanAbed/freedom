import 'package:freedom_chat_app/core/usecases/use_cases.dart';
import 'package:freedom_chat_app/freedom/search/domain/repositories/repo.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

class SearchUsersUseCase extends UseCase<Stream<List<UserModel>>, String> {
  final SearchRepo _repo;

  SearchUsersUseCase({required SearchRepo repo}) : _repo = repo;
  @override
  Stream<List<UserModel>> call([String? query]) {
    return _repo.search(query!);
  }
}
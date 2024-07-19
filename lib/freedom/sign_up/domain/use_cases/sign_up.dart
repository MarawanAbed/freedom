import 'package:freedom_chat_app/core/usecases/use_cases.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';
import 'package:freedom_chat_app/freedom/sign_up/domain/repositories/repo.dart';

class SignUpUseCase extends UseCase<Future<void>,UserModel>
{
  final SignUpRepository _repo;

  SignUpUseCase({required SignUpRepository repo}) : _repo = repo;
  @override
  Future<void> call([UserModel? user]) async {
    await _repo.signUp(user!);
  }

}
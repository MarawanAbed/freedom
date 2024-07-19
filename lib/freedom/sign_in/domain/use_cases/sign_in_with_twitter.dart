import 'package:freedom_chat_app/core/usecases/use_cases.dart';
import 'package:freedom_chat_app/freedom/sign_in/domain/repositories/repo.dart';

class SignInWithTwitterUseCase extends UseCase<Future<void>, NoParameter> {
  final SignInRepo _repo;

  SignInWithTwitterUseCase({required SignInRepo repo}) : _repo = repo;

  @override
  Future<void> call([NoParameter? parameter]) async {
    await _repo.signInWithTwitter();
  }
}

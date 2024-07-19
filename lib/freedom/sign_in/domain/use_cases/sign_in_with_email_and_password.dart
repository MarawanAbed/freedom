import 'package:freedom_chat_app/core/usecases/use_cases.dart';
import 'package:freedom_chat_app/freedom/sign_in/domain/repositories/repo.dart';

class SignInWithEmailAndPasswordUseCase extends UseCaseTwoParam<Future<void>,String,String>
{
  final SignInRepo _repo;

  SignInWithEmailAndPasswordUseCase({required SignInRepo repo}) : _repo = repo;


  @override
  Future<void> call([String? parameter1, String? parameter2])async {
    await _repo.signInWithEmailAndPassword(parameter1!, parameter2!);
  }

}
import 'package:freedom_chat_app/core/usecases/use_cases.dart';
import 'package:freedom_chat_app/freedom/forget_password/domain/repositories/repo.dart';

class ForgetPasswordUseCase extends UseCase<Future<void>,String>
{
  final ForgetPasswordRepo _repo;

  ForgetPasswordUseCase({required ForgetPasswordRepo repo}) : _repo = repo;
  @override
  Future<void> call([String? parameter]) async{
    await _repo.forgetPassword(parameter!);
  }

}
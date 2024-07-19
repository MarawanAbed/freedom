import 'package:freedom_chat_app/core/usecases/use_cases.dart';
import 'package:freedom_chat_app/freedom/verify_email/domain/repositories/repo.dart';

class SendEmailVerificationUseCase extends UseCase<Future<void>,NoParameter>
{
  final VerifyRepository _repo;

  SendEmailVerificationUseCase({required VerifyRepository repo}) : _repo = repo;
  @override
  Future<void> call([NoParameter? parameter])async {
    await _repo.sendVerificationEmail();
  }

}
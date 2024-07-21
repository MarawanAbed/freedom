import 'package:freedom_chat_app/core/usecases/use_cases.dart';
import 'package:freedom_chat_app/freedom/home/domain/repositories/repo.dart';

class UpdateUserUseCase extends UseCase<Future<void>,Map<String,dynamic>>
{
  final HomeRepo _repo;

  UpdateUserUseCase({required HomeRepo repo}):_repo = repo;
  @override
  Future<void> call([Map<String, dynamic> ?parameter])async {
    await _repo.updateUser(parameter!);
  }

}
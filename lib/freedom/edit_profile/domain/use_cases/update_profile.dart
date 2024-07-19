import 'package:freedom_chat_app/core/usecases/use_cases.dart';
import 'package:freedom_chat_app/freedom/edit_profile/domain/repositories/repo.dart';

class UpdateProfileUseCase extends UseCase<Future<void>,Map<String,dynamic>>
{
  final EditProfileRepo _repo;

  UpdateProfileUseCase({required EditProfileRepo repo}):_repo = repo;
  @override
  Future<void> call([Map<String, dynamic> ?parameter])async {
    await _repo.updateUser(parameter!);
  }

}
import 'package:freedom_chat_app/freedom/profile/data/data_sources/remote_data_source.dart';
import 'package:freedom_chat_app/freedom/profile/domain/repositories/repo.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ProfileRemoteDataSource profileDataSource;

  ProfileRepoImpl({required this.profileDataSource});

  @override
  Stream<UserModel> getUser() {
   try
   {
     return profileDataSource.getUser();
   }
   catch(e)
   {
     throw e;
   }
  }

}
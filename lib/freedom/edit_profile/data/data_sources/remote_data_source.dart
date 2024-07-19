import 'package:freedom_chat_app/core/services/firebase_services.dart';

abstract class EditProfileRemoteDataSource {

  Future<void> updateUser(Map<String, dynamic> data);
}

class EditProfileRemoteDataSourceImpl extends EditProfileRemoteDataSource {
  final DatabaseService _service;

  EditProfileRemoteDataSourceImpl({required DatabaseService service}) : _service = service;


  @override
  Future<void> updateUser(Map<String, dynamic> data) async {
    await _service.updateUser(data);
  }
}
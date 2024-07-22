import 'dart:io';

import 'package:freedom_chat_app/core/services/firebase_services.dart';

abstract class EditProfileRemoteDataSource {

  Future<void> updateUser(Map<String, dynamic> data);
  Future<String> uploadImage(File path);
}

class EditProfileRemoteDataSourceImpl extends EditProfileRemoteDataSource {
  final DatabaseService _service;
  final StorageService _storageService;
  EditProfileRemoteDataSourceImpl({required DatabaseService service,required StorageService storageService }) : _service = service,_storageService=storageService;


  @override
  Future<void> updateUser(Map<String, dynamic> data) async {
    await _service.updateUser(data);
  }

  @override
  Future<String> uploadImage(File path)async {
    return await _storageService.uploadImage(path);
  }
}
import 'dart:io';

import 'package:freedom_chat_app/core/services/firebase_services.dart';
import 'package:freedom_chat_app/freedom/chat/data/models/messages.dart';

abstract class ChatRemoteDataSource {
  Future<void> addMessage(
      {required MessagesModel messageEntity, required MessageType messageType});

  Stream<List<MessagesModel>> getAllMessage(String receiverId);

  Future<String> uploadImage(File imageFile);
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final DatabaseService _databaseService;
  final StorageService _storageService;

  ChatRemoteDataSourceImpl(
      {required DatabaseService databaseService,
      required StorageService storageService})
      : _databaseService = databaseService,
        _storageService = storageService;

  @override
  Future<void> addMessage(
      {required MessagesModel messageEntity,
      required MessageType messageType}) async {
    await _databaseService.addMessage(
        messageEntity: messageEntity, messageType: messageType);
  }

  @override
  Stream<List<MessagesModel>> getAllMessage(String receiverId) {
    return _databaseService.getAllMessage(receiverId: receiverId);
  }

  @override
  Future<String> uploadImage(File imageFile) async{
    return await _storageService.uploadImage(imageFile);
  }
}

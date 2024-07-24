import 'dart:io';

import 'package:freedom_chat_app/freedom/chat/data/data_sources/remote_data_source.dart';
import 'package:freedom_chat_app/freedom/chat/data/models/messages.dart';
import 'package:freedom_chat_app/freedom/chat/domain/repositories/repo.dart';

class ChatRepoImpl extends ChatRepo {
  final ChatRemoteDataSource _dataSource;

  ChatRepoImpl({required ChatRemoteDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<void> addMessage(
      {required MessagesModel messageEntity,
      required MessageType messageType}) async {
    try {
      await _dataSource.addMessage(
          messageEntity: messageEntity, messageType: messageType);
    } catch (error) {
      throw error;
    }
  }

  @override
  Stream<List<MessagesModel>> getAllMessage(String receiverId) {
    try {
      return _dataSource.getAllMessage(receiverId);
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<String> uploadImage(File imageFile) async{
    try {
      return await _dataSource.uploadImage(imageFile);
    } catch (error) {
      throw error;
    }
  }
}

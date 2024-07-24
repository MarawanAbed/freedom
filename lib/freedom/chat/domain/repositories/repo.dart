import 'dart:io';

import 'package:freedom_chat_app/freedom/chat/data/models/messages.dart';

abstract class ChatRepo
{
  Future<void> addMessage({required MessagesModel messageEntity, required MessageType messageType});
  Stream<List<MessagesModel>> getAllMessage(String receiverId);
  Future<String> uploadImage(File imageFile);
}
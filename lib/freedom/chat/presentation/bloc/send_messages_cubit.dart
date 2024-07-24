import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/core/di/dependancy_injection.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/services/notification_services.dart';
import 'package:freedom_chat_app/freedom/chat/data/models/messages.dart';
import 'package:freedom_chat_app/freedom/chat/domain/repositories/repo.dart';
import 'package:freedom_chat_app/freedom/chat/domain/use_cases/send_message.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_messages_cubit.freezed.dart';
part 'send_messages_state.dart';

class SendMessagesCubit extends Cubit<SendMessagesState> {
  SendMessagesCubit(this._sendMessageUseCase, this._repo)
      : super(const SendMessagesState.initial());

  final SendMessageUseCase _sendMessageUseCase;
  final ChatRepo _repo;
  File? profileImage;
  String? imageUrl;

  addMessageText({
    required String content,
    required String receiverId,
    required UserModel user,
  }) async {
    emit(const SendMessagesState.loading());
    try {
      final messageEntity = MessagesModel(
        content: content,
        receiverId: receiverId,
        sendTime: DateTime.now(),
        messageType: MessageType.text,
      );
      await _sendMessageUseCase.call(messageEntity, MessageType.text);
      var receiverToken =
          await getIt<RemoteNotificationService>().getReceiverToken(receiverId);
      await getIt<RemoteNotificationService>().sendNotification(
          receiverToken: receiverToken,
          title: user.name!,
          body: content,
          senderId: user.uId!,
          user: user);
      emit(const SendMessagesState.success());
    } catch (e) {
      emit(SendMessagesState.error(e.toString()));
    }
  }

  addMessageImage({
    required String receiverId,
    required UserModel user,
  }) async {
    emit(const SendMessagesState.loading());
    try {
      profileImage = await HelperMethod.getImageFromGallery();
      final imageUrl = await uploadImage();
      final messageEntity = MessagesModel(
        content: imageUrl,
        receiverId: receiverId,
        sendTime: DateTime.now(),
        messageType: MessageType.image,
      );
      await _sendMessageUseCase.call(messageEntity, MessageType.image);
      var receiverToken =
          await getIt<RemoteNotificationService>().getReceiverToken(receiverId);
      await getIt<RemoteNotificationService>().sendNotification(
        receiverToken: receiverToken,
        title: user.name!,
        body: 'sent you an image',
        senderId: user.uId!,
        user: user,
      );
      emit(const SendMessagesState.success());
    } catch (e) {
      emit(SendMessagesState.error(e.toString()));
    }
  }

  Future<String> uploadImage() async {
    emit(const SendMessagesState.loading());
    if (profileImage == null) {
      return 'no image selected';
    }
    try {
      imageUrl = await _repo.uploadImage(profileImage!);
      return imageUrl ?? 'failed to upload image';
    } catch (e) {
      emit(SendMessagesState.error(e.toString()));
      return 'failed to upload image';
    }
  }
}

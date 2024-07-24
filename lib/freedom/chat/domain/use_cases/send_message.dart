import 'package:freedom_chat_app/core/usecases/use_cases.dart';
import 'package:freedom_chat_app/freedom/chat/data/models/messages.dart';
import 'package:freedom_chat_app/freedom/chat/domain/repositories/repo.dart';

class SendMessageUseCase extends UseCaseTwoParam<Future<void>,MessagesModel,MessageType>{

  final ChatRepo _chatRepo;

  SendMessageUseCase({required ChatRepo chatRepo}) : _chatRepo = chatRepo;
  @override
  Future<void> call([MessagesModel? parameter1, MessageType? parameter2])async {
    return await _chatRepo.addMessage(messageEntity: parameter1!, messageType: parameter2!);
  }

}
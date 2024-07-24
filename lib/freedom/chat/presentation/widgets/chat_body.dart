import 'package:flutter/material.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/widgets/chat_field.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/widgets/chat_message.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key, required this.user, required this.senderId});
  final UserModel user;
  final String senderId;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Expanded(
          child: ChatMessage(
            user: user,
            senderId: senderId,
          ),
        ),
        const Divider(
          color: Colors.grey,
        ),
         ChatTextField(
          user: user,
         ),
      ],
    );
  }
}

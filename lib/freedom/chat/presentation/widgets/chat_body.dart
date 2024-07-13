import 'package:flutter/material.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/widgets/chat_field.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/widgets/chat_message.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          child: ChatMessage(
          ),
        ),
        const Divider(
          color: Colors.grey,
        ),
        ChatTextField(),
      ],
    );
  }
}

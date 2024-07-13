import 'package:flutter/material.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/widgets/chat_appbar.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/widgets/chat_body.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      appBar: ChatAppBar(
      ),
      body: ChatBody(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/widgets/chat_appbar.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/widgets/chat_body.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late UserModel user;

  @override
  void didChangeDependencies() {
    user = ModalRoute.of(context)!.settings.arguments as UserModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  ChatAppBar(
        user: user,
      ),
      body: ChatBody(
        user: user,
      ),
    );
  }
}

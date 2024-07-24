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
  String senderId = '';

  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    user = args['user'] as UserModel;
    senderId = args['senderId'] as String? ?? user.uId!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
        user: user,
      ),
      body: ChatBody(
        user: user,
        senderId: senderId,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/bloc/get_all_messages_cubit.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/widgets/build_chat_messages.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

class ChatMessage extends StatefulWidget {
  const ChatMessage({super.key, required this.user});

  final UserModel user;

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<GetAllMessagesCubit>().getAllMessages(widget.user.uId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllMessagesCubit, GetAllMessagesState>(
      buildWhen: (previous, current) =>
          current is Success || current is Error || current is Loading,
      builder: (context, state) {
        return state.when(
          initial: () {
            return const Center(child: CircularProgressIndicator());
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          success: (messages) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            });
            return messages.isEmpty
                ? const Center(child: Text('No messages yet'))
                : BuildChatMessage(
                    scrollController: _scrollController,
                    user: widget.user,
                    messages: messages,
                  );
          },
          error: (message) {
            return Center(child: Text(message));
          },
        );
      },
    );
  }
}

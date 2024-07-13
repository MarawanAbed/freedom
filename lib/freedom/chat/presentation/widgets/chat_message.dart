import 'package:flutter/material.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/widgets/build_chat_messages.dart';

class ChatMessage extends StatefulWidget {
  const ChatMessage({super.key});

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BuildChatMessage(
      scrollController: _scrollController,
    );
  }
}
//    return BlocProvider.value(
//       value: _cubit,
//       child: BlocBuilder<GetAllMessagesCubit, GetAllMessagesState>(
//           buildWhen: (previous, current) =>
//           current is Loaded || current is Error || current is Loading,
//           builder: (context, state) {
//             return state.when(initial: () {
//               return const Center(child: CircularProgressIndicator());
//             }, loading: () {
//               return const Center(child: CircularProgressIndicator());
//             }, loaded: (messages) {
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 _scrollController.animateTo(
//                   _scrollController.position.maxScrollExtent,
//                   duration: const Duration(milliseconds: 500),
//                   curve: Curves.easeInOut,
//                 );
//               });
//               return BuildChatMessage(
//                 scrollController: _scrollController,
//                 user: widget.user,
//                 messages: messages,
//               );
//             }, error: (message) {
//               return Center(child: Text(message));
//             });
//           }),
//     );

import 'package:flutter/material.dart';
import 'package:freedom_chat_app/freedom/chat/presentation/widgets/message_bubble.dart';


class BuildChatMessage extends StatelessWidget {
  const BuildChatMessage(
      {super.key,  required this.scrollController});

  final ScrollController scrollController;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemBuilder: (BuildContext context, int index) {
        //that isMe is used to check if the message is sent by the user or not
        //is not quality to the user id of the message then it is not sent by the user
        // final isMe = messages[index].senderId != user.uId;
        return MessageBubble(
          isMe: false,
          // messageModel: ,
        );
      },
      itemCount:2,
    );
  }
}

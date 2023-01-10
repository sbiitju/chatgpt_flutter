import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';
import '../../../data/models/chatmodel.dart';
import '../../../data/models/user_type.dart';

class ChatCard extends StatelessWidget {
  final ChatModel chatModel;

  ChatCard({required this.chatModel});

  @override
  Widget build(BuildContext context) {
    return chatModel.userType == UserType.USER
        ? _makeUserChatListRow(chatModel)
        : _makeBotChatListRow(chatModel);
  }

  Widget _makeBotChatListRow(ChatModel chatModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(child: Image.asset("images/gpt.png")),
          ),
          Expanded(
            child: Container(
                decoration: const BoxDecoration(
                    color: AppColors.botBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(chatModel?.message?.trim() ?? ""),
                )),
          ),
        ],
      ),
    );
  }

  Widget _makeUserChatListRow(ChatModel chatModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
                decoration: const BoxDecoration(
                    color: AppColors.botBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(chatModel.message ?? ""),
                )),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
                child: Icon(
              Icons.person,
              size: 30,
            )),
          )
        ],
      ),
    );
  }
}

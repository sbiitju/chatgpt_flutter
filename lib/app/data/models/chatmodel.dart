import 'package:chatgpt/app/data/models/user_type.dart';

class ChatModel {
  String? message;
  UserType? userType;
  ChatModel({required this.message, this.userType = UserType.BOT});

  ChatModel.fromJson(Map<String, dynamic> json) {
    message = json["text"];
    userType = UserType.BOT;
  }
}

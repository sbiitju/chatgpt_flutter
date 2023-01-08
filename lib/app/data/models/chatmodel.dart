import 'package:chatgpt/app/data/models/user_type.dart';

class ChatModel {
  String? meesage;
  UserType? userType;
  ChatModel({required this.meesage, this.userType = UserType.BOT});

  ChatModel.fromJson(Map<String, dynamic> json) {
    meesage = json["text"];
    userType = UserType.BOT;
  }
}

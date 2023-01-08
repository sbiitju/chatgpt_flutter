import '../models/chatmodel.dart';

abstract class DataSource {
  Future<ChatModel> getResponse(String input);
}

import 'dart:convert';

import '../models/chatmodel.dart';
import 'base_data_source.dart';
import 'datasource.dart';

class DataSourceImp extends BaseDataSource implements DataSource {
  @override
  Future<ChatModel> getResponse(String input) async {
    var url = Uri.https("api.openai.com", "/v1/completions");
    final response = await dioClient.post(url.toString(),
        data: jsonEncode({
          "model": "text-davinci-003",
          "prompt": input,
          'max_tokens': 1000,
        }));
    return ChatModel.fromJson(
        (response.data["choices"] as List<dynamic>).first);
  }
}

import 'package:chatgpt/app/data/service/datasource.dart';
import 'package:chatgpt/app/data/service/datasource_imp.dart';
import 'package:get/get.dart';

import '../../../data/models/chatmodel.dart';

class HomeController extends GetxController {
  RxBool isLoading = RxBool(false);
  RxList<ChatModel> chatList = RxList();
  var url = Uri.https("api.openai.com", "/v1/completions");
  final DataSource dataSource = DataSourceImp();
  Future callData(String prompt) async {
    return chatList.add(await dataSource.getResponse(prompt).then((value) {
      isLoading.value = false;
      return value;
    }));
  }
}

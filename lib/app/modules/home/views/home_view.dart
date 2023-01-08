import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/values/app_colors.dart';
import '../../../data/models/chatmodel.dart';
import '../../../data/models/user_type.dart';
import '../components/chat_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final _textEditingController = TextEditingController();
  final _scrollController = ScrollController();
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          title: const Text("ChatGPT-SB"),
          centerTitle: true,
        ),
        body: Obx(() => Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: controller.chatList.isEmpty
                        ? Center(
                            child: Text(
                              "Ask Something!!!\nChatGPT is ready to give your answer.",
                              style: GoogleFonts.athiti(fontSize: 18),
                            ),
                          )
                        : _makeChatList()),
                _makeProgressBar()
              ],
            )));
  }

  _makeChatList() {
    return ListView.separated(
        shrinkWrap: true,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: ChatCard(chatModel: controller.chatList[index]),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: controller.chatList.length);
  }

  _makeProgressBar() {
    return controller.isLoading.value
        ? Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "ChatGPT is Writing your answer......",
                    style: GoogleFonts.abel(),
                  ),
                  const RefreshProgressIndicator(
                      backgroundColor: AppColors.backgroundColor,
                      color: AppColors.appBarColor),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: Row(
              children: [
                Form(
                  child: Flexible(
                    child: TextField(
                      maxLines: 2,
                      cursorRadius: const Radius.circular(10),
                      cursorColor: AppColors.colorWhite,
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(color: Colors.white),
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.chatList.length > 2
                                ? makeScrollingDown()
                                : null;
                            controller.isLoading.value = true;
                            controller.chatList.add(ChatModel(
                                meesage: _textEditingController.text.toString(),
                                userType: UserType.USER));
                            controller
                                .callData(
                                    _textEditingController.text.toString())
                                .whenComplete(() {
                              controller.isLoading.value = false;
                              makeScrollingDown();
                              _textEditingController.clear();
                            });
                          },
                          icon: const Icon(
                            Icons.send,
                            color: AppColors.colorBlack,
                          ),
                        ),
                        hintText: "Write your asking here.",
                        fillColor: AppColors.botBackgroundColor,
                        filled: true,
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.botBackgroundColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.backgroundColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        disabledBorder: InputBorder.none,
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.botBackgroundColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  void makeScrollingDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 500,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/constant/colors.dart';
import 'package:fire/models/message.dart';
import 'package:fire/shared/widgets/chat_bubble.dart';
import 'package:fire/shared/widgets/default_text_form.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController messageController = TextEditingController();
  bool validate = false;
  final listController = ScrollController();
  CollectionReference messages =
      AppFirebase.store.collection(AppFirebase.kMessagesCollection);
  GlobalKey<FormState> formValidate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages
          .orderBy(AppFirebase.kCreatedAt, descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];

          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/whats.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor:Colors.transparent,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      height: 60,
                    ),
                    const Text(
                      "Chat",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        controller: listController,
                        itemCount: messageList.length,
                        reverse: true,
                        itemBuilder: (c, index) {
                          return messageList[index].id == email
                              ? ChatBubble(message: messageList[index])
                              : ChatBubbleForFriend(
                                  message: messageList[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: formValidate,
                      child: DefaultTextForm(
                        controller: messageController,
                        submit: (value) {
                          messages.add({
                            AppFirebase.kMessage: value,
                            AppFirebase.kCreatedAt: DateTime.now(),
                            AppFirebase.kId: email,
                          });
                          messageController.clear();
                          listController.animateTo(
                            0,
                            duration: const Duration(seconds: 5),
                            curve: Curves.easeIn,
                          );
                        },
                        hint: "EnterMessage",
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Message must be empty";
                          }
                          return null;
                        },
                        pressIcon: () {
                          if (formValidate.currentState!.validate()) {
                            messages.add({
                              AppFirebase.kMessage: messageController.text,
                              AppFirebase.kCreatedAt: DateTime.now(),
                              AppFirebase.kId: email,
                            });
                            messageController.clear();
                            listController.animateTo(
                              0,
                              duration: const Duration(seconds: 5),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        suffix: Icons.send,
                        color: const Color(0xffa5a8af),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

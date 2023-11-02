import 'package:fire/models/message.dart';
import 'package:flutter/material.dart';
class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});
final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding:const  EdgeInsets.only(left: 16.0 , top: 16.0, right: 16.0 , bottom: 16.0),
        decoration: const  BoxDecoration(
            color: Color(0xff272a35),
            borderRadius:  BorderRadius.only(
              topRight: Radius.circular(15.0),
              topLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
        ),
        child:  Text(
          message.message,
          style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 14
          ),
        ),
      ),
    );
  }
}


class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(

        margin: const EdgeInsets.all(10.0),
        padding:const  EdgeInsets.only(left: 16.0 , top: 16.0, right: 16.0 , bottom: 16.0),
        decoration: const BoxDecoration(
          color: Color(0xff373e4e),
          borderRadius:  BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
          ),
        ),
        child:  Text(
          message.message,
          style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 14
          ),
        ),
      ),
    );
  }
}

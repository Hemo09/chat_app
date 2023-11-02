import 'package:fire/constant/colors.dart';

class Message
{
  final String message;
  final String id;
  Message(this.message , this.id);
  factory Message.fromJson(json){
    return Message(json[AppFirebase.kMessage] , json[AppFirebase.kId]);
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AppColor
{
  static const kPrimaryColor = Color(0xff1571a2);


}
//firebase
class AppFirebase
{
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore store = FirebaseFirestore.instance;
  static String kMessagesCollection = "messages";
  static String kMessage = "message";
  static String kCreatedAt = "createAt";
  static String kId = "id";

}
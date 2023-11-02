import 'package:fire/constant/routes.dart';
import 'package:fire/views/screens/home_page.dart';
import 'package:fire/views/screens/login_page.dart';
import 'package:fire/views/screens/signup.dart';
import 'package:flutter/cupertino.dart';

Map<String, Widget Function(BuildContext)> routes  =
{
  AppRoutes.loginPage :(context)=>LoginPage(),
  AppRoutes.registerPage:(context)=>SignUp(),
  AppRoutes.homePage:(context)=> HomePage(),

};
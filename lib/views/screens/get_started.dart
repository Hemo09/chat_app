import 'package:fire/constant/routes.dart';
import 'package:fire/shared/widgets/default_button.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 50,
              bottom: 200,
              child: Image.asset("assets/getStarted.png",),
            ),
            Positioned(
              left: 200,
              top: 0.67,
              bottom: 500,
              right: 20,
              child: Image.asset("assets/person1.png",),
            ),
            Positioned(
              left: 180,
              bottom: 350,
              right: 0,
              child: Image.asset("assets/person2.png",height: 150,),
            ),
            const Positioned(
              bottom: 140,
              left: 30,
              child: Text("Let’s Get \nStarted" , style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,

              ),),
            ),
              Positioned(
              bottom: 25,
              left: 50,
              child: DefaultButton(text: 'get started', press: ()
              {
              Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
              },),
            ),
          ],
        ),
      ),
    );
  }
}

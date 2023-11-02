import 'package:flutter/material.dart';
class DefaultButton extends StatelessWidget {
  final String text;
  final void Function()? press;
  const DefaultButton({super.key, required this.text , this.press});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color:const Color(0xff22396a),
      ),
      child: MaterialButton(
        onPressed: press,
        child:  Text(text.toUpperCase() , style:const  TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 23,
        )),
      ),
    );
  }
}

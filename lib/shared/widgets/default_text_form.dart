import 'package:fire/constant/colors.dart';
import 'package:flutter/material.dart';
class DefaultTextForm extends StatelessWidget {
  DefaultTextForm({super.key,this.suffix,this.color,this.pressIcon, this.controller, this.tap, this.submit, this.validate, required this.type, this.secure = false, required this.hint});
  final TextEditingController? controller;
  final void Function()? tap;
  final void Function(String?)? submit;
  final String? Function(String?)? validate;
  final TextInputType type;
  final bool? secure ;
  final String hint;
  IconData? suffix;
  Color? color;
  void Function()? pressIcon;


  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: const Color(0xff1f232f),
      ),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.white,
        ),
            controller: controller,
            onFieldSubmitted: submit,
            validator: validate,
            keyboardType: type,
            obscureText:secure! ,
            decoration:  InputDecoration(
              errorStyle: const TextStyle(
                color: Colors.white,
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color:Colors.white,
                )
              ),
              suffixIcon: IconButton( onPressed: pressIcon, icon: Icon(suffix  ,color: color,)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                      color: AppColor.kPrimaryColor
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                      color: AppColor.kPrimaryColor
                  )),
              hintText: hint,
              hintStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w400
              ),
            ),
          ),
    );

  }
}

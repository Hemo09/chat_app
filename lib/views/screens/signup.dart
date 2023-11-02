import 'package:fire/constant/colors.dart';
import 'package:fire/constant/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../shared/widgets/default_button.dart';
import '../../shared/widgets/default_text_form.dart';
class SignUp extends StatefulWidget {
   SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
   var emailController = TextEditingController();
   bool secure = false;
   bool vSecure = false;

var passController = TextEditingController();

var verifyPassController = TextEditingController();

   var validate = GlobalKey<FormState>();

bool isLoading = false;

   @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: validate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Create",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    "Account :)",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text("Email" , style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),),
                  const SizedBox(height: 8,),
                  DefaultTextForm(
                    hint: "Email",
                    type:TextInputType.emailAddress,
                    secure: false,
                    validate: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return "Email must not be empty";
                      }
                      return null;
                    },

                    controller: emailController,
                  ),
                  const SizedBox(height: 15,),
                  const Text("Password" , style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),),
                  const SizedBox(height: 8,),
                  DefaultTextForm(
                    hint: "Password",
                    type:TextInputType.visiblePassword,
                    secure: secure,
                    suffix: secure? Icons.visibility_outlined:Icons.visibility_off_outlined,
                    pressIcon: (){
                      setState(() {
                        secure =!secure;
                      });
                    },
                    validate: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return "password must not be empty";
                      }
                      return null;
                    },

                    controller: passController,
                  ),
                  const SizedBox(height: 15,),
                  const Text("Password" , style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),),
                  const SizedBox(height: 8,),
                  DefaultTextForm(
                    hint: "Re-Password",
                    type:TextInputType.visiblePassword,
                    secure: vSecure,
                    suffix: vSecure? Icons.visibility_outlined:Icons.visibility_off_outlined,
                    pressIcon: (){
                      setState(() {
                        vSecure =!vSecure;
                      });
                    },
                    validate: (value)
                    {
                      if(passController.text != verifyPassController.text)
                      {
                        return "password doesn't match";
                      }
                      return null;
                    },

                    controller: verifyPassController,
                  ),
                  const SizedBox(height: 40,),
                   Center(child: isLoading ? const CircularProgressIndicator(): DefaultButton(text: "Sign up" , press: ()
                   async {
                     if(validate.currentState!.validate())
                     {
                       try {
                         setState(() {
                           isLoading = true;
                         });
                         final credential = await AppFirebase.auth
                             .createUserWithEmailAndPassword(
                           email: emailController.text,
                           password: passController.text,
                         );
                         Navigator.pushNamed(context, AppRoutes.homePage, arguments: emailController.text);
                       } on FirebaseAuthException catch (e) {
                         if (e.code == 'weak-password') {
                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('weak-password')));
                         } else if (e.code == 'email-already-in-use') {
                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("email-already-in-use")));
                         }
                       } catch (e) {
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                       }
                       setState(() {
                         isLoading = false;
                       });

                     }
                   },)),
                  const SizedBox( height: 15,),
                  const SizedBox(height: 9,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have an account?" , style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.grey.withOpacity(.8),
                      ),),
                      const SizedBox(width: 5,),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, AppRoutes.loginPage );
                        },
                        child: const Text("login" , style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                          color: Colors.teal,
                        ),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

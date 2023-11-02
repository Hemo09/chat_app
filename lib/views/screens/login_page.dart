import 'package:fire/constant/colors.dart';
import 'package:fire/shared/widgets/default_button.dart';
import 'package:fire/shared/widgets/default_text_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constant/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var validate = GlobalKey<FormState>();
  bool secure = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Hi There! 👋",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff203a6e),
                    ),
                  ),
                  const Text(
                    "Welcome back, Sign in to Your account.",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DefaultTextForm(
                    hint: "Email",
                    type: TextInputType.emailAddress,
                    secure: false,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Email must not be empty";
                      }
                      return null;
                    },
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DefaultTextForm(
                    hint: "Password",
                    type: TextInputType.visiblePassword,
                    secure: secure,
                    suffix: secure? Icons.visibility_outlined:Icons.visibility_off_outlined,
                    pressIcon: (){
                      setState(() {
                        secure =!secure;
                      });
                    },
                    color: Colors.white,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "password must not be empty";
                      }
                      return null;
                    },
                    controller: passController,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : DefaultButton(
                              text: "Login",
                              press: () async {
                                if (validate.currentState!.validate()) {
                                  try {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    final credential = await AppFirebase.auth
                                        .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passController.text,
                                    );
                                    Navigator.pushReplacementNamed(
                                        context, AppRoutes.homePage,
                                        arguments: emailController.text);
                                  } on FirebaseAuthException catch (ex) {
                                    if (ex.code == 'user-not-found') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text("user not found")));
                                    } else if (ex.code == 'wrong-password') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text("wrong password")));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "there was an error check your credential")));
                                    }
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              })),
                  const SizedBox(
                    height: 15,
                  ),
                  const Center(
                    child: Text(
                      "Forgotten Password?",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.grey.withOpacity(.8),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.registerPage);
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: Colors.teal,
                          ),
                        ),
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

/*
*
                  },*/

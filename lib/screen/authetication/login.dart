import 'package:flutter/material.dart';
import 'package:namer_app/components/authTextFormField.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:namer_app/screen/authetication/signup.dart';
import 'package:namer_app/services/google_auth_service.dart';

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

final _formKey = GlobalKey<FormState>();
final emailController = TextEditingController();
final passwordController = TextEditingController();

void signIn(context) async {
  try {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    emailController.clear();
    passwordController.clear();

    Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);

    if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
      errorMessage(context, 'Incorrect User Credentials');
    } else {
      errorMessage(context, e.code);
    }
  }
}

void errorMessage(context, message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
        );
      });
}

//Allowed characters for email
String allowed =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = RegExp(allowed);
void validation(context) {
  final form = _formKey.currentState;
  if (form!.validate()) {
    signIn(context);
  }
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    //  rebuild the UI when the state changes
    return Scaffold(
        //backgroundColor: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        body: Form(
      key: _formKey,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Add this
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 5,
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 300,
                  child: Image(
                    image: AssetImage("assets/images/main_vector.png"),
                  ),
                )),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                textDirection: TextDirection.ltr,
                children: [
                  const Text(
                    'Log In',
                    style: TextStyle(
                      color: Color(0xFF755DC1),
                      fontSize: 27,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthTextFormField(
                    controller: emailController,
                    name: "Email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Email";
                      } else if (!regExp.hasMatch(value)) {
                        return "Email in invalid";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthTextFormField(
                    controller: passwordController,
                    obsecureText: true,
                    name: "Password",
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please fill Password";
                      } else if (value.length < 8) {
                        return "Password is too short";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: SizedBox(
                      width: 329,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          validation(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(159, 123, 255, 1),
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'or',
                    style: TextStyle(
                      color: Color(0xFF837E93),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: SizedBox(
                      width: 250,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          AuthService().signInWithGoogle();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.black, width: 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: Image.asset(
                                'assets/icons/google_icon.png',
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            const Text(
                              'Sign in with Google',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don’t have an account?',
                        style: TextStyle(
                          color: Color(0xFF837E93),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 2.5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) => Signup()));
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFF755DC1),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: Color(0xFF755DC1),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

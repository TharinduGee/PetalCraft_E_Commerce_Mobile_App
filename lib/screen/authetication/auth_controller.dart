import 'package:english_words/english_words.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController{

  AuthController({
    required this.formKey ,
    required this.emailController,
    required this.passwordController
  });

  final GlobalKey<FormState> formKey ;
  final TextEditingController emailController ;
  final TextEditingController passwordController ;

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
final String allowed =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
void validation(context) {
  final form = formKey.currentState;
  if (form!.validate()) {
    signIn(context);
  }
}



}

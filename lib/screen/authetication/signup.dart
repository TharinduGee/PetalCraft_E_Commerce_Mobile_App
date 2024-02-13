import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/components/authTextFormField.dart';
import 'package:namer_app/screen/authetication/login.dart';
import 'package:namer_app/screen/navigationMenu/NavigationMenu.dart';
import 'package:namer_app/services/customer_service.dart';
import 'package:namer_app/services/notification_service.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

final CustomerService database = CustomerService();

final _formKey = GlobalKey<FormState>();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final usernameController = TextEditingController();
final confirmPasswordController = TextEditingController();
final phoneNoController = TextEditingController();

void signUp(context) async {
  try {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);

    String uId = FirebaseAuth.instance.currentUser!.uid.toString();
    database.addDocument(
        uId, usernameController, emailController, phoneNoController);

    NotificationService().publishNotification(
        uId, "Welcome to PetalCraft 🌟 , Happy exploring! 🚀", false);

    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => NavigationMenu()));
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);

    if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
      errorMessage(context, 'Incorrect User Credentials');
    } else if (e.code == 'EMAIL_ALREADY_EXCISTS') {
      errorMessage(context, 'Email already excists !');
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

String allowed =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = RegExp(allowed);
void validation(context) {
  final form = _formKey.currentState;
  if (form!.validate()) {
    if (confirmPasswordController.text == passwordController.text) {
      print("Yes");

      signUp(context);
    } else {
      errorMessage(context, "Invalid Password");
    }
  } else {
    print("No");
  }
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: Image(
                    image: AssetImage("assets/images/main_vector.png"),
                    height: 250,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    textDirection: TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          color: Color(0xFF755DC1),
                          fontSize: 27,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Username is Too Short";
                            } else if (value.length < 6) {
                              return "Please Enter a Username";
                            }
                            return null;
                          },
                          name: "Username",
                          controller: usernameController),
                      SizedBox(
                        height: 17,
                      ),
                      AuthTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Email";
                            } else if (!regExp.hasMatch(value)) {
                              return "Your Email is Invalid";
                            }
                            return null;
                          },
                          name: "Email",
                          controller: emailController),
                      SizedBox(
                        height: 17,
                      ),
                      AuthTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please fill Password";
                            } else if (value.length < 8) {
                              return "Password is too short";
                            }
                            return null;
                          },
                          obsecureText: true,
                          name: "Password",
                          controller: passwordController),
                      SizedBox(
                        height: 17,
                      ),
                      AuthTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please fill Password";
                            } else if (value.length < 8) {
                              return "Password is too short";
                            }
                            return null;
                          },
                          obsecureText: true,
                          name: "Confirm Password",
                          controller: confirmPasswordController),
                      SizedBox(
                        height: 17,
                      ),
                      AuthTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please fill Phone No";
                            } else if (value.length < 8) {
                              return "Invalid Phone No";
                            }
                            return null;
                          },
                          name: "Phone no",
                          controller: phoneNoController),
                      SizedBox(
                        height: 25,
                      ),
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: SizedBox(
                          width: 329,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              // widget.controller.animateToPage(2,
                              //     duration: const Duration(milliseconds: 500),
                              //     curve: Curves.ease);
                              validation(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF9F7BFF),
                            ),
                            child: const Text(
                              'Create account',
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
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            ' Have an account?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF837E93),
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 3.5,
                          ),
                          InkWell(
                            onTap: () {
                              // widget.controller.animateToPage(0,
                              //     duration: const Duration(milliseconds: 500),
                              //     curve: Curves.ease);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (ctx) => LogIn()),
                              );
                            },
                            child: const Text(
                              'Log In ',
                              style: TextStyle(
                                color: Color(0xFF755DC1),
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

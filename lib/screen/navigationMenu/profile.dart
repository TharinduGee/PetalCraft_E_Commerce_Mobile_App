import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/models/customer.dart';
import 'package:namer_app/screen/navigationMenu/home.dart';
import 'package:namer_app/services/customer_service.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    // Future<String> username;
    String uId = FirebaseAuth.instance.currentUser!.uid.toString();
    CustomerService cusservice = CustomerService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF755DC1),
        title: Text("Profile"),
        actions: [SignOutButton()],
      ),
      body: FutureBuilder<Customer>(
        future: cusservice.getUser(uId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Wait..."));
          } else if (snapshot.hasError) {
            return Text("error");
          } else {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        // Add your stack widgets here
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            snapshot.data.username.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFFC542),
                            size: 30,
                          ),
                          SizedBox(width: 5),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Text(
                            "Hi",
                            style: TextStyle(fontSize: 20),
                          ),
                          // Add your other widgets here
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Hi",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                          // Add your other widgets here
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Add more widgets here
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

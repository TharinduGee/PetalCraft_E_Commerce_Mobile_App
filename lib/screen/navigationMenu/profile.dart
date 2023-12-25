import 'package:flutter/material.dart';
import 'package:namer_app/services/userService.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: logOut,
          child: Text("Log Out"),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  Customer(
      {required this.username, required this.email, required this.phoneNo});

  final String username;
  final String email;
  final String phoneNo;

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phoneNo': phoneNo,
    };
  }

  factory Customer.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Customer(
      email: data?['email'],
      phoneNo: data?['phoneNo'],
      username: data?['username'],
    );
  }
}

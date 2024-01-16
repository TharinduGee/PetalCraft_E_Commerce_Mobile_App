import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  Customer(
      {required this.uId,
      required this.username,
      required this.email,
      required this.phoneNo});

  final String uId;
  final String username;
  final String email;
  final String phoneNo;

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
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
      uId: data?['uId'],
      email: data?['email'],
      phoneNo: data?['phoneNo'],
      username: data?['username'],
    );
  }
}

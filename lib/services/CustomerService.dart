import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/models/customer.dart';

class CustomerService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addDocument(
    TextEditingController usernameController,
    TextEditingController emailController,
    TextEditingController phoneNoController,
  ) async {
    final Customer customer = Customer(
        username: usernameController.text,
        email: emailController.text,
        phoneNo: phoneNoController.text);

    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("Customers")
        .where(emailController.text, isEqualTo: customer.email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      print("Customer with this email already exists!");
    } else {
      Map<String, dynamic> customerMap = customer.toMap();
      db.collection("Customers").add(customerMap).then(
          (DocumentReference doc) =>
              print('DocumentSnapshot added with ID: ${doc.id}'));
    }
  }

  Future<String> getUsername(String email) async {
    //var email = FirebaseAuth.instance.currentUser?.email.toString();
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Customers')
        .where("email", isEqualTo: email)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return "";
    } else {
      QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          snapshot.docs[0];

      return Customer.fromFirestore(documentSnapshot).username;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotification {
  AppNotification(
      {required this.customerId, required this.message, required this.status});

  final String customerId;
  final String message;
  bool status;

  Map<String, dynamic> toMap() {
    return {
      "customerId": customerId,
      'message': message,
      "status": status,
    };
  }

  factory AppNotification.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return AppNotification(
      customerId: data?['customerId'],
      message: data?['message'],
      status: data?['status'],
    );
  }
}

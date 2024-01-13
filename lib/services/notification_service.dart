import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namer_app/models/notifications.dart';

class NotificationService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> publishNotification(
      String customerId, String message, bool status) async {
    final Notification notification =
        Notification(customerId: customerId, message: message, status: status);

    Map<String, dynamic> notificationMap = notification.toMap();

    db.collection("Notifications").add(notificationMap).then(
        (DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
  }
}

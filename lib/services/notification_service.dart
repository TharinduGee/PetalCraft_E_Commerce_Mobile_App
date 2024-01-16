import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namer_app/models/notification.dart';
import 'package:namer_app/models/product.dart';

class NotificationService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> publishNotification(
      String customerId, String message, bool status) async {
    final AppNotification notification = AppNotification(
        customerId: customerId, message: message, status: status);

    Map<String, dynamic> notificationMap = notification.toMap();

    db.collection("Notifications").add(notificationMap).then(
        (DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  Future<Set<AppNotification>> getNotifications(String customerId) async {
    final notifications = <AppNotification>{};
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Notifications')
        .where("customerId", isEqualTo: customerId)
        .limit(20)
        .get();
    


    if (snapshot.docs.isEmpty) {
      print("No notifications....");
    } else {
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in snapshot.docs) {
        notifications.add(AppNotification.fromFirestore(documentSnapshot));
      }
    }

    return notifications;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> newGetNotifications(String customerId) async {
    final notifications = <AppNotification>{};
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Notifications')
        .where("customerId", isEqualTo: customerId)
        .limit(20)
        .get();
    
    

    if (snapshot.docs.isEmpty) {
      print("No notifications....");
    } else {
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in snapshot.docs) {
        notifications.add(AppNotification.fromFirestore(documentSnapshot));
      }
    }

    return snapshot;
  }

  Future markAsReadNotifcation(String docId) async {
    await FirebaseFirestore.instance
        .collection('Notifications')
        .doc(docId)
        .update({
      'status': true,
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/services/notification_service.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationService notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    final String uId = FirebaseAuth.instance.currentUser!.uid.toString();
    return Scaffold(
      appBar: AppBar(
          title: Text("Notification"), backgroundColor: Color(0xFF9F7BFF)),
      body: FutureBuilder(
          future: notificationService.newGetNotifications(uId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text('No Products available.'),
              );
            } else {
              List<String> documentIds = [];
              List<Map<String, dynamic>> notificationsData = [];

              for (QueryDocumentSnapshot<Map<String, dynamic>> document
                  in snapshot.data!.docs) {
                documentIds.add(document.id);
                notificationsData.add(document.data());
              }

              return Center(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  padding: EdgeInsets.all(4),
                  itemBuilder: (context, index) {
                    return NotificationItem(
                      docId: documentIds[index],
                      message: notificationsData[index]['message'],
                      status: notificationsData[index]['status'],
                    );
                  },
                ),
              );
            }
          }),
    );
  }
}

class NotificationItem extends StatefulWidget {
  final String docId;
  final String message;
  bool status;

  NotificationItem({
    required this.docId,
    required this.status,
    required this.message,
    //required this.time
  });

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.message),
      tileColor: widget.status ? Colors.green.shade50 : Colors.lightBlueAccent,
      leading: widget.status
          ? Icon(Icons.notifications)
          : Icon(Icons.notifications_active),
      onTap: () {
        //status chanege
        setState(() {
          if (widget.status == false) {
            NotificationService().markAsReadNotifcation(widget.docId);
            widget.status = !widget.status;
          }
          // Toggle the status
        });
      },
    );
  }
}

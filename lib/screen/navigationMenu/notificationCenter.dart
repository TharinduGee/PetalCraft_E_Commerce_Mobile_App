import 'package:flutter/material.dart';
import 'package:namer_app/services/notification_service.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationService notificationService = NotificationService();

  final List<Map<String, String>> notifications = [
    {'message': 'New message received', 'time': '10:00 AM', 'status': 'true'},
    {
      'message': 'Reminder: Meeting at 2 PM',
      'time': '12:30 PM',
      'status': 'true'
    },
    {'message': 'New message received', 'time': '10:00 AM', 'status': 'true'},
    {
      'message': 'Reminder: Meeting at 2 PM',
      'time': '12:30 PM',
      'status': 'true'
    },
    {'message': 'New message received', 'time': '10:00 AM', 'status': 'true'},
    {
      'message': 'Reminder: Meeting at 2 PM',
      'time': '12:30 PM',
      'status': 'true'
    },
    {'message': 'New message received', 'time': '10:00 AM', 'status': 'true'},
    {
      'message': 'Reminder: Meeting at 2 PM',
      'time': '12:30 PM',
      'status': 'true'
    },
    {'message': 'New message received', 'time': '10:00 AM', 'status': 'true'},
    {
      'message': 'Reminder: Meeting at 2 PM',
      'time': '12:30 PM',
      'status': 'true'
    },
    {'message': 'New message received', 'time': '10:00 AM', 'status': 'true'},
    {
      'message': 'Reminder: Meeting at 2 PM',
      'time': '12:30 PM',
      'status': 'true'
    },
    {'message': 'New message received', 'time': '10:00 AM', 'status': 'true'},
    {
      'message': 'Reminder: Meeting at 2 PM',
      'time': '12:30 PM',
      'status': 'true'
    },
    {'message': 'New message received', 'time': '10:00 AM', 'status': 'true'},
    {
      'message': 'Reminder: Meeting at 2 PM',
      'time': '12:30 PM',
      'status': 'true'
    },
    {'message': 'New message received', 'time': '10:00 AM', 'status': 'true'},
    {
      'message': 'Reminder: Meeting at 2 PM',
      'time': '12:30 PM',
      'status': 'true'
    },
    {'message': 'New message received', 'time': '10:00 AM', 'status': 'true'},
    {
      'message': 'Reminder: Meeting at 2 PM',
      'time': '12:30 PM',
      'status': 'true'
    },
    {'message': 'New message received', 'time': '10:00 AM', 'status': 'true'},
    {
      'message': 'Reminder: Meeting at 2 PM',
      'time': '12:30 PM',
      'status': 'true'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Notification"), backgroundColor: Color(0xFF9F7BFF)),
      body: FutureBuilder(
          future: notificationService.publishNotification(
              "001", "This is demo notofication", false),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData ) {
              return Center(
                child: Text('No Products available.'),
              );
            } else {
              return Center(
                child: Text('Function is escuted'),
              );
            }
          }),
      // ListView.builder(
      //   itemCount: notifications.length,
      //   itemBuilder: (context, index) {
      //     return NotificationItem(
      //       message: notifications[index]['message']!,
      //       time: notifications[index]['time']!,
      //       //status: notifications[index]['status']!,
      //     );
      //   },
      // ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String message;
  final String time;
  final bool status;

  NotificationItem(
      {required this.status, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(message),
      subtitle: Text(time),
      tileColor: Colors.redAccent,
      leading: Icon(Icons.notifications),
      onTap: () {
        //status chanege
      },
    );
  }
}

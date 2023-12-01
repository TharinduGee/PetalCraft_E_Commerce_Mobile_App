// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:namer_app/screen/firestore_service.dart';

// class ProfileViewer extends StatefulWidget {
//   const ProfileViewer({super.key});

//   @override
//   State<ProfileViewer> createState() => _ProfileViewerState();
// }

// final Database database = Database();

// class _ProfileViewerState extends State<ProfileViewer> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: database.addDocument(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else if (!snapshot.hasData) {
//             return Center(
//               child: Text('No image URLs available.'),
//             );
//           } else {
//             return Text("added...");
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void logOut() async {
  await FirebaseFirestore.instance.clearPersistence();
  FirebaseAuth.instance.signOut();
}

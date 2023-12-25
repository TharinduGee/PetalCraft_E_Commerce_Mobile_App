import 'package:firebase_auth/firebase_auth.dart';


void logOut() {
  FirebaseAuth.instance.signOut();
}
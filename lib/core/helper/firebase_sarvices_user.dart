import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<String?> fetchUserName() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection("buyers")
        .doc(user.uid)
        .get();

    if (doc.exists) {
      return doc['name'];
    }

    return null;
  }
}

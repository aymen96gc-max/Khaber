import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:khabar/screens/auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // body: ListView(
    //   children: [
    //     FirebaseAuth.instance.currentUser != null
    //         ? (FirebaseAuth.instance.currentUser!.emailVerified
    //               ? const Text('Email Verified')
    //               : const Text('Email Not Verified'))
    //         : const Text('No User Signed In'),
    //   ],
    // ),
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}

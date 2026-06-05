import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khabar/core/helper/auth_switcher.dart';
import 'package:khabar/core/helper/bottom_switcher.dart';
import 'package:khabar/features/UI/login_screen.dart';

class HomeSwitcher extends StatelessWidget {
  const HomeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),

        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BottomSwitcher(); // Replace with your home screen widget
          } else {
            return AuthScreen(); // Replace with your login screen widget
          }
        },
      ),
    );
  }
}

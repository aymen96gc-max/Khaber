import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khabar/core/helper/saler_bottom_switcher.dart';
import 'package:khabar/core/helper/saler_auth_switcher.dart';

class SalerHomeSwitcher extends StatelessWidget {
  const SalerHomeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),

        builder: (builder, snapshot) {
          if (snapshot.hasData) {
            return SalerBottomSwitcher(); // Replace with your home screen widget
          } else {
            return SalerAuthScreen(); // Replace with your login screen widget
          }
        },
      ),
    );
  }
}

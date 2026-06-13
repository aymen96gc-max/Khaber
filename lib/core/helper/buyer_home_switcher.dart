import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khabar/core/helper/buyer_bottom_switcher.dart';
import 'package:khabar/core/helper/buyer_auth_switcher.dart';

class BuyerHomeSwitcher extends StatelessWidget {
  const BuyerHomeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (builder, snapshot) {
          if (snapshot.hasData) {
            return BuyerBottomSwitcher(); // Replace with your home screen widget
          } else {
            return BuyerAuthScreen(); // Replace with your login screen widget
          }
        },
      ),
    );
  }
}

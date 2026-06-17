import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khabar/core/helper/buyer_bottom_switcher.dart';
import 'package:khabar/core/helper/buyer_auth_switcher.dart';

class BuyerHomeSwitcher extends StatelessWidget {
  const BuyerHomeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data != null) {
            return BuyerBottomSwitcher();
          }
          return BuyerAuthScreen();
        },
      ),
    );
  }
}

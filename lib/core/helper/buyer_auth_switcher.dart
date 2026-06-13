import 'package:flutter/material.dart';
import 'package:khabar/features/UI/buyer/buyer_login_screen.dart';
import 'package:khabar/features/UI/buyer/buyer_signup_screen.dart';

class BuyerAuthScreen extends StatefulWidget {
  const BuyerAuthScreen({super.key});

  @override
  State<BuyerAuthScreen> createState() => _BuyerAuthScreenState();
}

class _BuyerAuthScreenState extends State<BuyerAuthScreen> {
  bool isLogin = true;
  void toggleScreen() => setState(() => isLogin = !isLogin);
  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return BuyerLoginScreen(onClickSignUp: toggleScreen);
    } else {
      return BuyerSignupScreen(onClickSignIn: toggleScreen);
    }
  }
}

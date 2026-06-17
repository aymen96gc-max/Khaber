import 'package:flutter/material.dart';
import 'package:khabar/features/UI/saler/saler_login_screen.dart';
import 'package:khabar/features/UI/saler/saler_signup_screen.dart';

class SalerAuthScreen extends StatefulWidget {
  const SalerAuthScreen({super.key});

  @override
  State<SalerAuthScreen> createState() => _SalerAuthScreenState();
}

class _SalerAuthScreenState extends State<SalerAuthScreen> {
  bool isLogin = true;
  void toggleScreen() => setState(() => isLogin = !isLogin);
  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return SalerLoginScreen(onClickSignUpSaler: toggleScreen);
    } else {
      return SalerSignupScreen(onClickSignInSaler: toggleScreen);
    }
  }
}

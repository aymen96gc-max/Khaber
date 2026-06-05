import 'package:flutter/material.dart';
import 'package:khabar/features/UI/login_screen.dart';
import 'package:khabar/features/UI/signup_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  void toggleScreen() => setState(() => isLogin = !isLogin);
  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginScreen(onClickSignUp: toggleScreen);
    } else {
      return SignupScreen(onClickSignIn: toggleScreen);
    }
  }
}

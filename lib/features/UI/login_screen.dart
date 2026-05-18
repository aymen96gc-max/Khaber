import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khabar/core/helper/extension.dart';
import 'package:khabar/core/routing/routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future login() async {
    // Implement your login logic here
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 60),

            Center(
              child: Column(
                children: const [
                  Image(
                    image: AssetImage("assets/svgs/khabar_logo.svg"),
                    height: 100,
                  ),
                  Text(
                    "تسجيل الدخول",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            // البريد
            const Text("البريد الالكتروني", textAlign: TextAlign.right),

            const SizedBox(height: 10),
            // email text field
            TextField(
              controller: emailController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: "البريد الالكتروني",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),

            const SizedBox(height: 20),
            // كلمة المرور
            const Text("كلمة المرور", textAlign: TextAlign.right),

            const SizedBox(height: 10),

            TextField(
              controller: passwordController,
              obscureText: true,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: "كلمة المرور",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "نسيت كلمة المرور؟",
              style: TextStyle(color: Colors.blue),
              textAlign: TextAlign.right,
            ),

            const SizedBox(height: 25),
            // login button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff174C8F),
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                login();
              },
              child: const Text("تسجيل الدخول", style: TextStyle(fontSize: 18)),
            ),

            const SizedBox(height: 30),

            Row(
              children: const [
                Expanded(child: Divider()),
                Text(" او "),
                Expanded(child: Divider()),
              ],
            ),

            const SizedBox(height: 15),

            const Center(child: Text("ليس لديك حساب؟")),

            TextButton(
              onPressed: () {
                context.pushNamed("/signupScreen");
              },
              child: const Text("انشاء حساب جديد"),
            ),

            const SizedBox(height: 20),

            // social buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [socialButton("Google"), socialButton("Apple")],
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [socialButton("Facebook"), socialButton("TikTok")],
            ),
          ],
        ),
      ),
    );
  }

  Widget socialButton(String text) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(child: Text(text)),
    );
  }
}

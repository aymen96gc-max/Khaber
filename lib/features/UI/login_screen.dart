import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khabar/core/helper/extension.dart';
import 'package:khabar/core/routing/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> login() async {
    try {
      setState(() {
        isLoading = true;
      });

      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      final user = userCredential.user;

      // ✅ جلب بيانات المستخدم من Firestore
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        print("User Data: ${doc.data()}");
      }

      if (!context.mounted) return;

      context.pushReplacementNamed(Routes.homeScreen);
    } on FirebaseAuthException catch (e) {
      String message = "حدث خطأ";

      if (e.code == 'user-not-found') {
        message = "المستخدم غير موجود";
      } else if (e.code == 'wrong-password') {
        message = "كلمة المرور خاطئة";
      } else if (e.code == 'invalid-email') {
        message = "البريد الإلكتروني غير صالح";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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

            // ✅ شعار
            Center(
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/svgs/khabar_logo.svg",
                    width: 100,
                    height: 100,
                  ),
                  const Text(
                    "تسجيل الدخول",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            const Text("البريد الالكتروني", textAlign: TextAlign.right),
            const SizedBox(height: 10),

            TextField(
              controller: emailController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: "البريد الالكتروني",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 20),

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

            const SizedBox(height: 25),

            // ✅ زر تسجيل الدخول
            ElevatedButton(
              onPressed: isLoading ? null : login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("تسجيل الدخول"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khabar/core/routing/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyerLoginScreen extends StatelessWidget {
  final VoidCallback onClickSignUpBuyer;
  const BuyerLoginScreen({super.key, required this.onClickSignUpBuyer});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    Future<void> login() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        // Navigate to home after successful login
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed(Routes.buyerhomeSwitcher);
        }
      } on FirebaseAuthException catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error: ${e.message}")));
        }
      }
    }

    return Directionality(
      textDirection: TextDirection.rtl, // Arabic layout
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 60),

              /// Logo + Title
              Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 80,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF1E4F8A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              /// Email
              buildTextField(
                "البريد الالكتروني",
                controller: emailController,
                isPassword: false,
              ),

              const SizedBox(height: 15),

              /// Password
              buildTextField(
                "كلمة المرور",
                controller: passwordController,
                isPassword: true,
              ),

              const SizedBox(height: 5),

              /// Forgot Password
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "نسيت كلمة المرور؟",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// Login Button
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E4F8A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "تسجيل الدخول",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// Divider (or)
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("او"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 20),

              /// Create Account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("ليس لديك حساب ؟ "),
                  GestureDetector(
                    onTap: () {
                      onClickSignUpBuyer();
                    },
                    child: const Text(
                      "انشاء حساب جديد",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// Social Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  socialButton("Apple", Icons.apple, () {}),
                  socialButton("Google", Icons.email, () {}),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  socialButton("Facebook", Icons.facebook, () {}),
                  socialButton("TikTok", Icons.tiktok, () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// TextField Widget
  Widget buildTextField(
    String hint, {
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF1E4F8A)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF1E4F8A), width: 2),
        ),
      ),
    );
  }

  /// Social Button
  Widget socialButton(String title, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 140,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        icon: Icon(icon),
        label: Text(title),
      ),
    );
  }
}

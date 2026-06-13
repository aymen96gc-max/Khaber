import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khabar/core/routing/routes.dart';

class BuyerSignupScreen extends StatefulWidget {
  final VoidCallback onClickSignIn;
  const BuyerSignupScreen({required this.onClickSignIn, super.key});

  @override
  State<BuyerSignupScreen> createState() => _BuyerSignupScreenState();

  /// TEXT FIELD
  static Widget textField({
    String label = "",
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class _BuyerSignupScreenState extends State<BuyerSignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController employeesController = TextEditingController();

  Future<void> signup() async {
    try {
      // Create Firebase account
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      // Store buyer data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'name': nameController.text.trim(),
            'email': emailController.text.trim(),
            'country': countryController.text.trim(),
            'city': cityController.text.trim(),
            'yearFounded': yearController.text.trim(),
            'employees': employeesController.text.trim(),
            'userType': 'buyer',
            'createdAt': FieldValue.serverTimestamp(),
          });

      // Navigate to home after successful signup
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(Routes.buyerhomeSwitcher);
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: ${e.message}")));
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    countryController.dispose();
    cityController.dispose();
    yearController.dispose();
    employeesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        widget.onClickSignIn();
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "انشاء حساب",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// SECTION TITLE
                const Text(
                  "معلومات المؤسسة :",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),

                const SizedBox(height: 16),

                /// NAME FIELD
                const Text("اسم المؤسسة او القناة"),
                const SizedBox(height: 6),
                BuyerSignupScreen.textField(
                  label: "أدخل اسم المؤسسة",
                  controller: nameController,
                ),

                const SizedBox(height: 12),

                /// EMAIL FIELD
                const Text("البريد الالكتروني"),
                const SizedBox(height: 6),
                BuyerSignupScreen.textField(
                  label: "name@gmail.com",
                  controller: emailController,
                ),

                const SizedBox(height: 12),

                /// PASSWORD FIELD
                const Text("كلمة المرور"),
                const SizedBox(height: 6),
                BuyerSignupScreen.textField(
                  label: "أدخل كلمة المرور",
                  controller: passwordController,
                  isPassword: true,
                ),

                const SizedBox(height: 12),

                /// COUNTRY + CITY
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("الدولة"),
                          const SizedBox(height: 6),
                          BuyerSignupScreen.textField(
                            label: "الدولة",
                            controller: countryController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("المدينة"),
                          const SizedBox(height: 6),
                          BuyerSignupScreen.textField(
                            label: "المدينة",
                            controller: cityController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                /// MORE FIELDS
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("سنة التأسيس"),
                          const SizedBox(height: 6),
                          BuyerSignupScreen.textField(
                            label: "سنة التأسيس",
                            controller: yearController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("عدد الموظفين"),
                          const SizedBox(height: 6),
                          BuyerSignupScreen.textField(
                            label: "عدد الموظفين",
                            controller: employeesController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E4F8A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: signup,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "انشاء الحساب",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ACTIVITY CARD
class activityCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const activityCard(this.icon, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.grey),
          const SizedBox(height: 10),
          Text(title, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

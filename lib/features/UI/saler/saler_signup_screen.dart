import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khabar/core/routing/routes.dart';

class SalerSignupScreen extends StatefulWidget {
  final VoidCallback onClickSignInSaler;
  const SalerSignupScreen({required this.onClickSignInSaler, super.key});

  @override
  State<SalerSignupScreen> createState() => _SalerSignupScreenState();
}

class _SalerSignupScreenState extends State<SalerSignupScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signup() async {
    try {
      // Create Firebase account (auto-logs in user)
      UserCredential salerCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      await FirebaseFirestore.instance
          .collection("salers")
          .doc(salerCredential.user?.uid)
          .set({
            "firstName": firstNameController.text.trim(),
            "lastName": lastNameController.text.trim(),
            "email": emailController.text.trim(),
            "phone": phoneController.text.trim(),
            "country": countryController.text.trim(),
            "city": cityController.text.trim(),
            "createdAt": FieldValue.serverTimestamp(),
          });
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Sign up error: ${e.message}")));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Firestore save error: ${e.toString()}")),
        );
      }
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    countryController.dispose();
    cityController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        widget.onClickSignInSaler();
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

                /// Name Row
                Row(
                  children: [
                    Expanded(
                      child: buildField(
                        "الاسم الأول",
                        "أدخل اسمك الأول",
                        firstNameController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: buildField(
                        "اسم العائلة",
                        "أدخل اسم عائلتك",
                        lastNameController,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                buildField(
                  "البريد الالكتروني",
                  "name@gmail.com",
                  emailController,
                ),

                const SizedBox(height: 15),

                buildField("رقم الهاتف", "********970+", phoneController),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: buildField(
                        "الدولة",
                        "- - - - -",
                        countryController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: buildField(
                        "المدينة",
                        "- - - - - - -",
                        cityController,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                buildField(
                  "كلمة المرور",
                  "أدخل كلمة المرور",
                  passwordController,
                ),

                const SizedBox(height: 25),

                /// Upload section
                const Text(
                  "رفع صورة الهوية الشخصية",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    color: Colors.red,
                    strokeWidth: 2,
                    dashPattern: [6, 4],
                    radius: const Radius.circular(12),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    alignment: Alignment.center,
                    child: const Text("ارفع صورة الهوية"),
                  ),
                ),

                const SizedBox(height: 20),

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
                    onPressed: () {
                      signup();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "ابدأ البيع",
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

  /// Input field widget
  Widget buildField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}

/// Feature Chip
class FeatureChip extends StatelessWidget {
  final String text;

  const FeatureChip(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text, style: const TextStyle(color: Colors.red)),
      backgroundColor: Colors.red.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}

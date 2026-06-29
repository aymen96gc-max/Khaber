import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';

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
  File? selectedIdImage;
  final ImagePicker picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final random = Random();

  Future<void> pickIdImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedIdImage = File(image.path);
      });
    }
  }

  Future<String?> uploadIdImage() async {
    if (selectedIdImage == null) return null;

    try {
      String fileName =
          "saller_ids/${DateTime.now().millisecondsSinceEpoch}.jpg";

      final ref = FirebaseStorage.instance.ref().child(fileName);

      await ref.putFile(selectedIdImage!);

      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  Future<void> signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedIdImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("يرجى رفع صورة الهوية"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Create Firebase account (auto-logs in user)
      UserCredential salerCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      final balance = 100 + random.nextInt(500);
      await salerCredential.user!.sendEmailVerification();
      final idImageUrl = await uploadIdImage();
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
            "idImage": idImageUrl,
            "balance": balance,
            "createdAt": FieldValue.serverTimestamp(),
          });
      if (mounted) {
        await FirebaseAuth.instance.signOut();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("تم إرسال رابط التحقق إلى بريدك الإلكتروني"),
          ),
        );

        widget.onClickSignInSaler();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign up have error: ${e.toString()}")),
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
            child: Form(
              key: _formKey,
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
                    "@gmail.com",
                    emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 15),

                  buildField(
                    "رقم الهاتف",
                    "+970 000 000000",
                    phoneController,
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: buildField("الدولة", " ", countryController),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildField("المدينة", " ", cityController),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  buildField(
                    "كلمة المرور",
                    "أدخل كلمة المرور",
                    passwordController,
                    keyboardType: TextInputType.visiblePassword,
                  ),

                  const SizedBox(height: 25),

                  /// Upload section
                  const Text(
                    "رفع صورة الهوية الشخصية",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: pickIdImage,
                    child: DottedBorder(
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
                        child: selectedIdImage == null
                            ? const Text("ارفع صورة الهوية")
                            : Image.file(selectedIdImage!, fit: BoxFit.cover),
                      ),
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
                        if (_formKey.currentState!.validate()) {
                          signup();
                        }
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
      ),
    );
  }

  Widget buildField(
    String label,
    String hint,
    TextEditingController controller, {
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),

        const SizedBox(height: 6),

        TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,

          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "هذا الحقل مطلوب";
            }

            if (label == "البريد الالكتروني") {
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

              if (!emailRegex.hasMatch(value.trim())) {
                return "البريد الإلكتروني غير صحيح";
              }
            }

            if (label == "رقم الهاتف") {
              final phoneRegex = RegExp(r'^(\+970|0)?5[0-9]{8}$');

              if (!phoneRegex.hasMatch(value.trim())) {
                return "رقم الهاتف غير صحيح";
              }
            }

            if (label == "كلمة المرور") {
              if (value.length < 6) {
                return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
              }
            }

            return null;
          },

          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,

            errorStyle: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blue),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
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

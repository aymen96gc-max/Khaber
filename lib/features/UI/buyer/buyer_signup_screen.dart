import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuyerSignupScreen extends StatefulWidget {
  final VoidCallback onClickSignInBuyer;

  const BuyerSignupScreen({required this.onClickSignInBuyer, super.key});

  @override
  State<BuyerSignupScreen> createState() => _BuyerSignupScreenState();
}

class _BuyerSignupScreenState extends State<BuyerSignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController employeesController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  String? selectedActivity;
  File? logoImage;
  final random = Random();

  Future<void> pickLogo() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        logoImage = File(image.path);
      });
    }
  }

  Future<String?> uploadLogo() async {
    if (logoImage == null) return null;

    try {
      final fileName =
          "buyers_logo_${DateTime.now().millisecondsSinceEpoch}.jpg";

      final ref = FirebaseStorage.instance
          .ref()
          .child("buyers_logos")
          .child(fileName);

      await ref.putFile(logoImage!);

      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  Future<void> signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedActivity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("يرجى اختيار نوع النشاط"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      final user = credential.user;

      if (user == null) {
        throw Exception("User not created");
      }

      await user.sendEmailVerification();
      final balance = 500 + random.nextInt(5000);

      final logoUrl = await uploadLogo();

      await FirebaseFirestore.instance.collection("buyers").doc(user.uid).set({
        "name": nameController.text.trim(),
        "activity": selectedActivity,
        "email": emailController.text.trim(),
        "phone": phoneController.text.trim(),
        "website": websiteController.text.trim(),
        "country": countryController.text.trim(),
        "city": cityController.text.trim(),
        "year": yearController.text.trim(),
        "employees": employeesController.text.trim(),
        "logo": logoUrl,
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

        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Sign up have error: $e")));
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    websiteController.dispose();
    passwordController.dispose();
    countryController.dispose();
    cityController.dispose();
    yearController.dispose();
    employeesController.dispose();
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
                  /// HEADER
                  Row(
                    children: [
                      InkWell(
                        onTap: widget.onClickSignInBuyer,
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
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: pickLogo,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.blue.shade100,
                            backgroundImage: logoImage != null
                                ? FileImage(logoImage!)
                                : null,
                            child: logoImage == null
                                ? const Icon(Icons.camera_alt, size: 40)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("شعار المؤسسة"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  buildField("اسم المؤسسة أو القناة", "", nameController),

                  const SizedBox(height: 15),

                  const SizedBox(height: 15),

                  /// COUNTRY + CITY
                  Row(
                    children: [
                      Expanded(
                        child: buildField(
                          "الدولة",
                          "الدولة",
                          countryController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildField("المدينة", "المدينة", cityController),
                      ),
                    ],
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "نوع النشاط",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      activityCard("قناة تلفزيون", Icons.tv),
                      const SizedBox(width: 10),
                      activityCard("وكالة أنباء", Icons.satellite_alt),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      activityCard("منصة رقمية", Icons.phone_android),
                      const SizedBox(width: 10),
                      activityCard("صحيفة إلكترونية", Icons.newspaper),
                    ],
                  ),

                  const SizedBox(height: 15),
                  const SizedBox(height: 16),

                  /// YEAR + EMPLOYEES
                  Row(
                    children: [
                      Expanded(
                        child: buildField(
                          "سنة التأسيس",
                          "2000",
                          yearController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildField(
                          "عدد الموظفين",
                          "50",
                          employeesController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  buildField(
                    "البريد الرسمي",
                    "",
                    emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 15),

                  buildField(
                    "رقم الهاتف",
                    "",
                    phoneController,
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 15),

                  buildField(
                    "الموقع الإلكتروني",
                    "",
                    websiteController,
                    keyboardType: TextInputType.url,
                  ),

                  const SizedBox(height: 15),

                  buildField(
                    "كلمة المرور",
                    "",
                    passwordController,
                    isPassword: true,
                  ),

                  const SizedBox(height: 30),

                  /// BUTTON
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
      ),
    );
  }

  Widget activityCard(String title, IconData icon) {
    final selected = selectedActivity == title;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedActivity = title;
          });
        },
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? Colors.blue : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40),
              const SizedBox(height: 10),
              Text(title),
            ],
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
      crossAxisAlignment: CrossAxisAlignment.end,
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

            if (label == "البريد الرسمي") {
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

              if (!emailRegex.hasMatch(value.trim())) {
                return "البريد الإلكتروني غير صحيح";
              }
            }

            if (label == "رقم الهاتف") {
              final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');

              if (!phoneRegex.hasMatch(value.trim())) {
                return "رقم الهاتف غير صحيح";
              }
            }

            if (label == "كلمة المرور") {
              if (value.length < 6) {
                return "كلمة المرور يجب أن تكون 6 أحرف أو أكثر";
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

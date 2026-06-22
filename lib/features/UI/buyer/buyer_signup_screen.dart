// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:khabar/core/routing/routes.dart';

// class BuyerSignupScreen extends StatefulWidget {
//   final VoidCallback onClickSignInBuyer;
//   const BuyerSignupScreen({required this.onClickSignInBuyer, super.key});

//   @override
//   State<BuyerSignupScreen> createState() => _BuyerSignupScreenState();

//   /// TEXT FIELD
//   static Widget textField({
//     String label = "",
//     required TextEditingController controller,
//     bool isPassword = false,
//   }) {
//     return TextField(
//       controller: controller,
//       obscureText: isPassword,
//       decoration: InputDecoration(
//         hintText: label,
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 12,
//           vertical: 12,
//         ),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//     );
//   }
// }

// class _BuyerSignupScreenState extends State<BuyerSignupScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController countryController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController yearController = TextEditingController();
//   final TextEditingController employeesController = TextEditingController();

//   Future<void> signup() async {
//     try {
//       final userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//             email: emailController.text.trim(),
//             password: passwordController.text.trim(),
//           );

//       await FirebaseFirestore.instance
//           .collection("buyers")
//           .doc(userCredential.user?.uid)
//           .set({
//             "name": nameController.text.trim(),
//             "email": emailController.text.trim(),
//             "country": countryController.text.trim(),
//             "city": cityController.text.trim(),
//             "year": yearController.text.trim(),
//             "employees": employeesController.text.trim(),
//             "createdAt": FieldValue.serverTimestamp(),
//           });
//     } on FirebaseAuthException catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text("Sign up error: ${e.message}")));
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Firestore save error: ${e.toString()}")),
//         );
//       }
//     }
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     countryController.dispose();
//     cityController.dispose();
//     yearController.dispose();
//     employeesController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF5F5F5),

//       body: SafeArea(
//         child: Directionality(
//           textDirection: TextDirection.rtl,
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 /// HEADER
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         widget.onClickSignInBuyer();
//                       },
//                       child: const Icon(Icons.arrow_back),
//                     ),
//                     const SizedBox(width: 10),
//                     const Text(
//                       "انشاء حساب",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 20),

//                 /// SECTION TITLE
//                 const Text(
//                   "معلومات المؤسسة :",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                 ),

//                 const SizedBox(height: 16),

//                 /// NAME FIELD
//                 const Text("اسم المؤسسة او القناة"),
//                 const SizedBox(height: 6),
//                 BuyerSignupScreen.textField(
//                   label: "أدخل اسم المؤسسة",
//                   controller: nameController,
//                 ),

//                 const SizedBox(height: 12),

//                 /// EMAIL FIELD
//                 const Text("البريد الالكتروني"),
//                 const SizedBox(height: 6),
//                 BuyerSignupScreen.textField(
//                   label: "name@gmail.com",
//                   controller: emailController,
//                 ),

//                 const SizedBox(height: 12),

//                 /// PASSWORD FIELD
//                 const Text("كلمة المرور"),
//                 const SizedBox(height: 6),
//                 BuyerSignupScreen.textField(
//                   label: "أدخل كلمة المرور",
//                   controller: passwordController,
//                   isPassword: true,
//                 ),

//                 const SizedBox(height: 12),

//                 /// COUNTRY + CITY
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           const Text("الدولة"),
//                           const SizedBox(height: 6),
//                           BuyerSignupScreen.textField(
//                             label: "الدولة",
//                             controller: countryController,
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           const Text("المدينة"),
//                           const SizedBox(height: 6),
//                           BuyerSignupScreen.textField(
//                             label: "المدينة",
//                             controller: cityController,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 16),

//                 /// MORE FIELDS
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           const Text("سنة التأسيس"),
//                           const SizedBox(height: 6),
//                           BuyerSignupScreen.textField(
//                             label: "سنة التأسيس",
//                             controller: yearController,
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           const Text("عدد الموظفين"),
//                           const SizedBox(height: 6),
//                           BuyerSignupScreen.textField(
//                             label: "عدد الموظفين",
//                             controller: employeesController,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 30),

//                 /// Submit Button
//                 SizedBox(
//                   width: double.infinity,
//                   height: 55,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF1E4F8A),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     onPressed: signup,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Text(
//                           "انشاء الحساب",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         SizedBox(width: 8),
//                         Icon(Icons.arrow_forward, color: Colors.white),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// ACTIVITY CARD
// class ActivityCard extends StatelessWidget {
//   final IconData icon;
//   final String title;

//   const ActivityCard(this.icon, this.title, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: Colors.black12),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 40, color: Colors.grey),
//           const SizedBox(height: 10),
//           Text(title, textAlign: TextAlign.center),
//         ],
//       ),
//     );
//   }
// }
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

  Future<void> signup() async {
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

      await FirebaseFirestore.instance.collection("buyers").doc(user.uid).set({
        "name": nameController.text.trim(),
        "email": user.email,
        "country": countryController.text.trim(),
        "city": cityController.text.trim(),
        "year": yearController.text.trim(),
        "employees": employeesController.text.trim(),
        "createdAt": FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ تم إنشاء الحساب بنجاح")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("خطأ: $e")));
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
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

                /// NAME
                buildField("اسم المؤسسة", "أدخل اسم المؤسسة", nameController),

                const SizedBox(height: 15),

                /// EMAIL
                buildField(
                  "البريد الالكتروني",
                  "name@gmail.com",
                  emailController,
                ),

                const SizedBox(height: 15),

                /// PASSWORD
                buildField(
                  "كلمة المرور",
                  "أدخل كلمة المرور",
                  passwordController,
                  isPassword: true,
                ),

                const SizedBox(height: 15),

                /// COUNTRY + CITY
                Row(
                  children: [
                    Expanded(
                      child: buildField("الدولة", "الدولة", countryController),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: buildField("المدينة", "المدينة", cityController),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                /// YEAR + EMPLOYEES
                Row(
                  children: [
                    Expanded(
                      child: buildField("سنة التأسيس", "2000", yearController),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: buildField(
                        "عدد الموظفين",
                        "50",
                        employeesController,
                      ),
                    ),
                  ],
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

  /// ✅ نفس ستايل Seller بالضبط
  Widget buildField(
    String label,
    String hint,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: isPassword,
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

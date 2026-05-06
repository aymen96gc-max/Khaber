import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:khabar/screens/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Future Login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    );
  }

  // Future signInWithGoogle() async {
  //   final googleUser = await RegisterScreen().signIn();

  //   if (googleUser == null) {
  //     // The user canceled the sign-in
  //     return;
  //   }

  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            //CustomButtonAuth (title: "Login", onPressed: () async {
            //         try {
            //   final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            //     email: email.text,
            //     password: password.text,
            //   );
            // } on FirebaseAuthException catch (e) {
            //   if (e.code == 'weak-password') {
            //     print('The password provided is too weak.');
            // AwesomeDialog(
            // context: context,
            // dialogType: DialogType.error,
            // animType: AnimType.rightSlide,
            // title: 'Dialog Title',
            // desc: 'message Error',
            // btnCancelOnPress: () {},
            // btnOkOnPress: () {},
            // ).show();
            //   } else if (e.code == 'email-already-in-use') {
            //     print('The account already exists for that email.');
            //   }
            // } catch (e) {
            //   print(e);
            // }
            //       }
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("home_screen");
              },
            ),

            /// to forget password
            // InkWell(
            //   onTap: () async{
            //     FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

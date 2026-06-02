import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khabar/core/helper/extension.dart';
import 'package:khabar/core/routing/routes.dart';

class Onboarding_screen_3ed extends StatelessWidget {
  const Onboarding_screen_3ed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 150),

              /// ✅ CAMERA CARD
              Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(13, 154, 255, 0.393),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/svgs/money_bag.svg',
                    height: 180,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// ✅ TITLE
              const Text(
                "منصة موثوقة وآمنة للشراء والبيع",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              /// ✅ DESCRIPTION
              const Text(
                "مع نظام دفع آمن وضمانات، يمكنك بيع صورك بثقة أو شراء محتوى حصري بأمان",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 40),

              /// ✅ DOT INDICATORS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_dot(), _dot(), _activeDot()],
              ),

              const Spacer(),

              /// ✅ BUTTON
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
                    // push in onboaredscreen 3
                    context.pushNamed(Routes.userTypeScreen);
                  },
                  child: const Text(
                    "التالي",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _activeDot() {
    /// ✅ ACTIVE DOT
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 25,
      height: 10,
      decoration: BoxDecoration(
        color: const Color(0xFF1E4F8A),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khabar/core/helper/extension.dart';
import 'package:khabar/core/routing/routes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          // padding: const EdgeInsets.all(24)
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
                    'assets/svgs/video_camera.svg',
                    height: 180,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// ✅ TITLE
              const Text(
                "بع فيديوهاتك للقنوات العالمية",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              /// ✅ DESCRIPTION
              const Text(
                "حول كاميرتك إلى مصدر دخل",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 5),

              /// ✅ DESCRIPTION
              const Text(
                " كل خبر تصوره قابل للبيع",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 35),

              /// ✅ DOT INDICATORS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_activeDot(), _dot(), _dot()],
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
                    context.pushNamed(Routes.onboarding2);
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

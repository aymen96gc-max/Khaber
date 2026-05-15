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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 30),

              /// ✅ LOGO SVG
              Column(
                children: [
                  SvgPicture.asset('assets/logo.svg', height: 80),
                  const SizedBox(height: 10),
                  const Text(
                    "khabar Agency",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              /// ✅ CAMERA CARD
              Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFA7C3DA),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/video_camera.svg',
                    height: 120,
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
                "حول كاميرتك إلى مصدر دخل — كل خبر تصوره قابل للبيع",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

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
                    /// ✅ الانتقال لصفحة ثانية
                    /// ✅ استخدام pushNamed مع اسم الصفحة من Routes
                    /// ✅ تأكد من أن AppRouter يعرف هذا المسار ويربطه بالصفحة الصحيحة
                    context.pushNamed(Routes.loginScreen);
                  },
                  child: const Text(
                    "التالي",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

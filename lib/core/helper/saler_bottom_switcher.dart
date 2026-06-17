import 'package:flutter/material.dart';
import 'package:khabar/features/UI/saler/saler_content.dart';
import 'package:khabar/features/UI/saler/saler_home_screen.dart';
import 'package:khabar/features/UI/saler/saler_notificitoin.dart';
import 'package:khabar/features/UI/saler/saler_profile_screen.dart';
import 'package:khabar/features/UI/saler/saler_upload_screen.dart';

class SalerBottomSwitcher extends StatefulWidget {
  const SalerBottomSwitcher({super.key});

  @override
  State<SalerBottomSwitcher> createState() => _SalerBottomSwitcherState();
}

class _SalerBottomSwitcherState extends State<SalerBottomSwitcher> {
  int currentIndex = 0;

  final List<Widget> screens = [
    SalerHomeScreen(),
    SalerUploadScreen(), // UploadScreen
    SalerContentScreen(), // OrdersScreen
    SalerNotificationsScreen(), // NotificationsScreen
    SalerProfileScreen(), // ProfileScreen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,

        type: BottomNavigationBarType.fixed, // ✅ مهم مع 5 عناصر

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: "رفع"),
          BottomNavigationBarItem(icon: Icon(Icons.flash_on), label: "طلبات"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "الإشعارات",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
        ],
      ),
    );
  }
}

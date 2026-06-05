import 'package:flutter/material.dart';
import 'package:khabar/features/UI/home_screen.dart';
import 'package:khabar/features/UI/notification.dart';
import 'package:khabar/features/UI/orders_screen.dart';
import 'package:khabar/features/UI/profile.dart';
import 'package:khabar/features/UI/upload_screen.dart';

class BottomSwitcher extends StatefulWidget {
  const BottomSwitcher({super.key});

  @override
  State<BottomSwitcher> createState() => _BottomSwitcherState();
}

class _BottomSwitcherState extends State<BottomSwitcher> {
  int currentIndex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    UploadScreen(), // UploadScreen
    OrdersScreen(), // OrdersScreen
    NotificationsScreen(), // NotificationsScreen
    ProfileScreen(), // ProfileScreen
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

import 'package:flutter/material.dart';
import 'package:khabar/features/UI/buyer/buyer_Purchases_screen.dart';
import 'package:khabar/features/UI/buyer/buyer_home_screen.dart';
import 'package:khabar/features/UI/buyer/buyer_profile_screen.dart';
import 'package:khabar/features/UI/buyer/buyer_preferred_screen.dart';
import 'package:khabar/features/UI/buyer/buyer_search_screen.dart';

class BuyerBottomSwitcher extends StatefulWidget {
  const BuyerBottomSwitcher({super.key});

  @override
  State<BuyerBottomSwitcher> createState() => _BuyerBottomSwitcherState();
}

class _BuyerBottomSwitcherState extends State<BuyerBottomSwitcher> {
  int currentIndex = 0;

  final List<Widget> screens = [
    BuyerHomeScreen(),
    BuyerSearchScreen(searchText: '', products: []),
    BuyerPreferredScreen(), // BuyerContentScreen
    BuyerPurchasesScreen(), // BuyerNotificationsScreen
    BuyerProfileScreen(), // BuyerProfileScreen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Color.fromARGB(255, 0, 42, 77),
        unselectedItemColor: Colors.black,

        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "بحث"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "المفضلة"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "المشتريات",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
        ],
      ),
    );
  }
}

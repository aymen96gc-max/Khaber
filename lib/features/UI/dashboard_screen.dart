import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: bottomNav(),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            const SizedBox(height: 30),

            Row(
              children: const [
                Icon(Icons.notifications),
                Spacer(),
                CircleAvatar(radius: 25, backgroundColor: Colors.red),
              ],
            ),

            const SizedBox(height: 10),

            const Text("مرحبا 👋"),
            const Text(
              "أنس شابط",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // ✅ Card الرصيد
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff8B0000), Color(0xffB22222)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: const [
                  Text("رصيدك الحالي", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 10),
                  Text(
                    "\$3,250",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                actionBox(Icons.message, "الرسائل"),
                actionBox(Icons.sell, "المبيعات"),
                actionBox(Icons.folder, "محتوى"),
                actionBox(Icons.upload, "رفع محتوى"),
              ],
            ),

            const SizedBox(height: 30),

            // ✅ احصائيات
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                stat("4.9", "تقييمك"),
                stat("8", "صفقات ناجحة"),
                stat("14", "مواد منشورة"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget actionBox(IconData icon, String text) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon),
        ),
        const SizedBox(height: 5),
        Text(text),
      ],
    );
  }

  static Widget stat(String number, String text) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(text),
      ],
    );
  }

  Widget bottomNav() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
        BottomNavigationBarItem(icon: Icon(Icons.upload), label: "رفع"),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "طلبات"),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: "الإشعارات",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
      ],
    );
  }
}

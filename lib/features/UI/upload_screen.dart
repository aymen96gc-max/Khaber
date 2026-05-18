import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      // ✅ Bottom Navigation
      bottomNavigationBar: bottomNav(),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            const SizedBox(height: 40),

            Row(
              children: const [
                Icon(Icons.arrow_back),
                Spacer(),
                Text("رفع محتوى جديد", style: TextStyle(fontSize: 20)),
              ],
            ),

            const SizedBox(height: 20),

            // ✅ Upload Box
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: const [
                  Icon(Icons.content_cut, size: 60),
                  SizedBox(height: 10),
                  Text("اسحب الملف هنا او اضغط الملف"),
                  Text("فيديو او صورة بدقة عالية"),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // ✅ buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [redBtn("فيديو"), redBtn("صور"), redBtn("صوت")],
            ),

            const SizedBox(height: 20),

            input("عنوان الخبر"),
            input("وصف مختصر", height: 100),

            Row(
              children: [
                Expanded(child: input("الدولة")),
                const SizedBox(width: 10),
                Expanded(child: input("المدينة")),
              ],
            ),

            const SizedBox(height: 10),

            // ✅ Map Box
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange[100],
              ),
              child: const Center(
                child: Text("اضغط لتحديد الموقع على الخريطة"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget input(String text, {double height = 50}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: height,
      child: TextField(
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: text,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget redBtn(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {},
        child: Text(text),
      ),
    );
  }

  Widget bottomNav() {
    return BottomNavigationBar(
      items: const [
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

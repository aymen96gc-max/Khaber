import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 40),

            Row(
              children: const [
                Icon(Icons.arrow_back),
                SizedBox(width: 10),
                Text(
                  "حساب بائع جديد",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(child: input("الاسم الاول")),
                const SizedBox(width: 10),
                Expanded(child: input("الاسم العائلة")),
              ],
            ),

            const SizedBox(height: 10),

            input("البريد الالكتروني"),
            input("رقم الهاتف"),
            Row(
              children: [
                Expanded(child: input("الدولة")),
                const SizedBox(width: 10),
                Expanded(child: input("المدينة")),
              ],
            ),
            input("كلمة المرور"),

            const SizedBox(height: 20),

            // Box رفع الهوية
            Container(
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(child: Text("ارفع صورة الهوية")),
            ),

            const SizedBox(height: 20),

            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(child: Text("اضغط لرفع صورتك")),
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 10,
              children: [
                "تحقق سريع",
                "حماية الحساب",
                "دفع مضمون",
              ].map((e) => Chip(label: Text(e))).toList(),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Text("ابدأ البيع"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget input(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: text,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

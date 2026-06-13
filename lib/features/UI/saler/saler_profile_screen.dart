import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SalerProfileScreen extends StatelessWidget {
  const SalerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              /// TITLE
              const Center(
                child: Text(
                  "الملف الشخصي و الحساب",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// PROFILE CARD
              cardContainer(
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/150?img=5",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "أنس شابط",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "بائع جديد",
                            style: TextStyle(color: Colors.green, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text("تسجيل الخروج"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              section("حسابي", [
                item(Icons.person, "البيانات الشخصية"),
                item(Icons.email, "تحديث البريد الإلكتروني"),
                item(Icons.lock, "تغيير كلمة البريد"),
              ]),

              section("الإعدادات", [
                item(Icons.settings, "تعديل المصادر"),
                item(Icons.text_fields, "حجم خط العناوين"),
                item(Icons.play_circle, "التشغيل التلقائي للفيديو"),
              ]),

              section("الإشعارات", [
                item(Icons.notifications, "الأخبار العاجلة"),
                item(Icons.markunread, "اشعار اهم الأخبار"),
                item(Icons.volume_up, "صوت الاشعارات"),
                item(Icons.bookmark, "المواضيع المحفوظة"),
              ]),

              /// DARK MODE
              cardContainer(
                child: Row(
                  children: [
                    Switch(
                      value: true,
                      onChanged: (v) {},
                      activeColor: Colors.blue,
                    ),
                    const Spacer(),
                    const Text("تفعيل الوضع الداكن"),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              section("تطبيق خبر", [
                item(Icons.publish, "انشر تطبيق خبر"),
                item(Icons.phone, "الاتصال بنا"),
                item(Icons.facebook, "Khaber app"),
                item(Icons.camera_alt, "Khaber app"),
                item(Icons.music_note, "Khaber app"),
                item(Icons.thumb_up, "قيم تطبيق خبر"),
                item(Icons.help, "الاسئلة الشائعة"),
                item(Icons.report_problem, "الابلاغ عن خلل"),
                item(Icons.privacy_tip, "سياسة الخصوصية"),
                item(Icons.gavel, "شروط الاستخدام"),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  /// SECTION TITLE + ITEMS
  static Widget section(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4, bottom: 6),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        cardContainer(child: Column(children: items)),
        const SizedBox(height: 16),
      ],
    );
  }

  /// ITEM ROW
  static Widget item(IconData icon, String text) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.blue),
      title: Text(text, textAlign: TextAlign.right),
    );
  }

  /// CARD CONTAINER
  static Widget cardContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(0.05)),
        ],
      ),
      child: child,
    );
  }
}

/// BOTTOM NAV

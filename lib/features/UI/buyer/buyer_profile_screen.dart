import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BuyerProfileScreen extends StatefulWidget {
  const BuyerProfileScreen({super.key});

  @override
  State<BuyerProfileScreen> createState() => _BuyerProfileScreenState();

  // SECTION TITLE + ITEMS
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

class _BuyerProfileScreenState extends State<BuyerProfileScreen> {
  String? name;
  String? email;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection("buyers")
            .doc(user.uid)
            .get();

        if (doc.exists) {
          final data = doc.data();
          setState(() {
            name = data?['name'] ?? '';
            email = data?['email'] ?? '';
            isLoading = false;
          });
        } else {
          setState(() => isLoading = false);
        }
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

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
              BuyerProfileScreen.cardContainer(
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
                        Text(
                          isLoading ? "جاري التحميل..." : name!,
                          style: const TextStyle(
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
                            "مشتري جديد",
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

              BuyerProfileScreen.section("حسابي", [
                BuyerProfileScreen.item(Icons.person, "البيانات الشخصية"),
                BuyerProfileScreen.item(Icons.email, "تحديث البريد الإلكتروني"),
                BuyerProfileScreen.item(Icons.lock, "تغيير كلمة البريد"),
              ]),

              BuyerProfileScreen.section("الإعدادات", [
                BuyerProfileScreen.item(Icons.settings, "تعديل المصادر"),
                BuyerProfileScreen.item(Icons.text_fields, "حجم خط العناوين"),
                BuyerProfileScreen.item(
                  Icons.play_circle,
                  "التشغيل التلقائي للفيديو",
                ),
              ]),

              BuyerProfileScreen.section("الإشعارات", [
                BuyerProfileScreen.item(Icons.notifications, "الأخبار العاجلة"),
                BuyerProfileScreen.item(Icons.markunread, "اشعار اهم الأخبار"),
                BuyerProfileScreen.item(Icons.volume_up, "صوت الاشعارات"),
                BuyerProfileScreen.item(Icons.bookmark, "المواضيع المحفوظة"),
              ]),

              /// DARK MODE
              BuyerProfileScreen.cardContainer(
                child: Row(
                  children: [
                    Switch(
                      value: true,
                      onChanged: (v) {},
                      activeThumbColor: Colors.blue,
                    ),
                    const Spacer(),
                    const Text("تفعيل الوضع الداكن"),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              BuyerProfileScreen.section("تطبيق خبر", [
                BuyerProfileScreen.item(Icons.publish, "انشر تطبيق خبر"),
                BuyerProfileScreen.item(Icons.phone, "الاتصال بنا"),
                BuyerProfileScreen.item(Icons.facebook, "Khaber app"),
                BuyerProfileScreen.item(Icons.camera_alt, "Khaber app"),
                BuyerProfileScreen.item(Icons.music_note, "Khaber app"),
                BuyerProfileScreen.item(Icons.thumb_up, "قيم تطبيق خبر"),
                BuyerProfileScreen.item(Icons.help, "الاسئلة الشائعة"),
                BuyerProfileScreen.item(Icons.report_problem, "الابلاغ عن خلل"),
                BuyerProfileScreen.item(Icons.privacy_tip, "سياسة الخصوصية"),
                BuyerProfileScreen.item(Icons.gavel, "شروط الاستخدام"),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

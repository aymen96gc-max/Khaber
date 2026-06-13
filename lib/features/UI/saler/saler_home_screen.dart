import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khabar/core/routing/routes.dart';

class SalerHomeScreen extends StatelessWidget {
  const SalerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.notifications,
                    color: Colors.amber,
                    size: 28,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text("👋 مرحباً", style: TextStyle(fontSize: 14)),
                      Text(
                        "أنس شابط",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  /// Avatar
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/150?img=3",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// BALANCE CARD
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff8B0000), Color(0xffC62828)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Stack(
                  children: [
                    /// blurred circle
                    Positioned(
                      left: 0,
                      top: 10,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "رصيدك الحالي",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          "\$3,250",
                          style: TextStyle(
                            fontSize: 34,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 14),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Withdraw
                            OutlinedButton.icon(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              icon: const Icon(
                                Icons.credit_card,
                                color: Colors.orange,
                              ),
                              label: const Text(
                                "سحب الرصيد",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  "إجمالي  \$11,420",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "معلق  \$850",
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// QUICK ACTIONS
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "الإجراءات السريعة",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  actionItem(
                    SvgPicture.asset("assets/svgs/upload.svg"),
                    "رفع محتوى",
                    Colors.blue,
                  ),
                  actionItem(
                    SvgPicture.asset("assets/svgs/content.svg"),
                    "محتواي",
                    Colors.cyan,
                  ),
                  actionItem(
                    SvgPicture.asset("assets/svgs/sales.svg"),
                    "المبيعات",
                    Colors.pink,
                  ),
                  actionItem(
                    SvgPicture.asset("assets/svgs/messages.svg"),
                    "الرسائل",
                    Colors.orange,
                  ),
                ],
              ),

              const SizedBox(height: 22),

              /// STATS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  statItem("4.9⭐", "تقييمك", "ممتاز"),
                  statItem("8", "صفقات ناجحة", "+3 هذا الشهر"),
                  statItem("14", "مواد منشورة", "+2 هذا الأسبوع"),
                ],
              ),

              const SizedBox(height: 22),

              /// CHART
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "الأرباح الشهرية",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 150,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    7,
                    (i) => Container(
                      width: 28,
                      height: [140, 120, 100, 80, 60, 90, 110][i].toDouble(),
                      decoration: BoxDecoration(
                        color: i == 0
                            ? Colors.redAccent
                            : Colors.redAccent.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// URGENT CARD
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff0D0D2B), Color(0xff2A2A72)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.flash_on, color: Colors.orange, size: 40),
                    const SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          "طلبات عاجلة بانتظارك",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "2 طلبات الآن",
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// SALES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "عرض الكل",
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  Text(
                    "آخر المبيعات",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              saleItem(
                "\$850+",
                "انفجار درعا — فيديو",
                "assets/images/sales1.jpg",
              ),
              saleItem(
                "\$420+",
                "اجتماع دمشق الطارئ",
                "assets/images/sales2.jpg",
              ),
              saleItem(
                "\$310+",
                "فيضانات اللاذقية — صور",
                "assets/images/sales3.jpg",
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ACTION ITEM
  static Widget actionItem(SvgPicture icon, String title, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: icon,
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  /// STAT ITEM
  static Widget statItem(String value, String label, String sub) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(sub, style: const TextStyle(color: Colors.green, fontSize: 12)),
      ],
    );
  }

  /// SALES ITEM

  static Widget saleItem(String price, String title, String imagePath) {
    return ListTile(
      leading: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.yellow.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(imagePath),
        ),
      ),
      title: Text(title, textAlign: TextAlign.right),
      subtitle: const Text("قناة الجزيرة"),
      trailing: Text(
        price,
        style: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

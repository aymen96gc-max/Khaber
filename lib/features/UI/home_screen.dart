import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khabar/core/helper/extension.dart';
import 'package:khabar/core/routing/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                /// Top Header
                Row(
                  children: [
                    const Icon(Icons.notifications, color: Colors.amber),
                    const Spacer(),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text("مرحبا بك", style: TextStyle(color: Colors.grey)),
                        Text(
                          "أحمد",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),

                    /// Avatar
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.red, Colors.redAccent],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// Balance Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7A0000), Color(0xFFD32F2F)],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        "رصيدك الحالي",
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "\$3,250",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "معلق\n\$850",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "إجمالي\n\$11,420",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                /// Withdraw Button
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(color: Colors.red),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.red,
                  ),
                  label: const Text(
                    "سحب الرصيد",
                    style: TextStyle(color: Colors.red),
                  ),
                ),

                const SizedBox(height: 25),

                /// Quick Actions
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "الإجراءات السريعة",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildAction(
                      "الرسائل",
                      "assets/svgs/messages.svg",
                      Colors.yellow.shade200,
                      () => context.pushNamed(Routes.massegeScreen),
                    ),
                    buildAction(
                      "المبيعات",
                      "assets/svgs/sales.svg",
                      Colors.red.shade200,
                      () => context.pushNamed(Routes.salesScreen),
                    ),
                    buildAction(
                      "محتواي",
                      "assets/svgs/content.svg",
                      Colors.blue.shade200,
                      () => context.pushNamed(Routes.contentScreen),
                    ),
                    buildAction(
                      "رفع محتوى",
                      "assets/svgs/upload.svg",
                      Colors.green.shade200,
                      () => context.pushNamed(Routes.uploadScreen),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                /// Stats
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "الاحصائيات",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    StatItem(title: "مواد منشورة", value: "14"),
                    StatItem(title: "صفقات ناجحة", value: "8"),
                    StatItem(title: "تقييمك", value: "4.9⭐"),
                  ],
                ),

                const SizedBox(height: 20),

                /// Earnings Section
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "الأسبوع",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text("شهر"),
                    const Spacer(),
                    const Text(
                      "الأرباح الشهرية",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// Fake Chart Bars
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buildBar(100, Colors.red),
                    buildBar(60, Colors.redAccent),
                    buildBar(40, Colors.redAccent),
                    buildBar(80, Colors.red),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Quick Action Widget
  Widget buildAction(
    String title,
    String icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: SvgPicture.asset(icon, height: 30),
          ),
          const SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }

  Widget buildBar(double height, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

/// Stats Widget
class StatItem extends StatelessWidget {
  final String title;
  final String value;

  const StatItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(title),
      ],
    );
  }
}

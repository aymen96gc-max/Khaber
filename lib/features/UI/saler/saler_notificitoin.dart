import 'package:flutter/material.dart';

class SalerNotificationsScreen extends StatelessWidget {
  const SalerNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              /// HEADER
              Row(
                children: const [
                  Icon(Icons.notifications, size: 26),
                  SizedBox(width: 8),
                  Text(
                    "الإشعارات",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const Text(
                "اليوم",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 12),

              /// -------- 1: SOLD --------
              notificationCard(
                icon: Icons.tv,
                color: Colors.teal,
                title: "قناة الجزيرة اشترت فيديو منك!",
                subtitle: "انفجار درعا - حصري 4K",
                trailing: Column(
                  children: [
                    badge("\$850", Colors.green),
                    const SizedBox(height: 6),
                    badge("حصري", Colors.blue),
                  ],
                ),
                actions: Row(
                  children: [
                    outlinedBtn("سحب الرصيد"),
                    const SizedBox(width: 10),
                    outlinedBtn("عرض الصفقة"),
                  ],
                ),
              ),

              /// -------- 2: URGENT --------
              notificationCard(
                icon: Icons.notifications_active,
                color: Colors.red,
                title: "طلب عاجل — غزة الآن",
                subtitle: "CNN تبحث عن مراسل ميداني",
                trailing: Column(
                  children: [
                    badge("\$1200", Colors.green),
                    const SizedBox(height: 6),
                    badge("ينتهي خلال 2h", Colors.orange),
                  ],
                ),
                actions: Row(
                  children: [
                    outlinedBtn("تجاهل"),
                    const SizedBox(width: 10),
                    filledBtn("قبول الطلب"),
                  ],
                ),
              ),

              /// -------- 3: ACCEPTED --------
              notificationCard(
                icon: Icons.check_circle,
                color: Colors.green,
                title: "تم قبول محتواك ونشره",
                subtitle: "فيضانات اللاذقية — متاح الآن",
                trailing: Column(
                  children: [
                    badge("\$220", Colors.green),
                    const SizedBox(height: 6),
                    badge("نشط", Colors.orange),
                  ],
                ),
              ),

              /// -------- 4: MESSAGE --------
              notificationCard(
                icon: Icons.chat,
                color: Colors.lightBlue,
                title: "قناة العربية أرسلت رسالة",
                subtitle: "نحتاج نسخة أطول من الفيديو",
                actions: Row(children: [filledBtn("رد الآن")]),
              ),

              /// -------- 5: PAYMENT DONE --------
              notificationCard(
                icon: Icons.attach_money,
                color: Colors.green,
                title: "تم تحويل رصيدك بنجاح",
                subtitle: "تم إرسال \$500 إلى PayPal",
                trailing: badge("تم التحويل", Colors.green),
              ),

              /// -------- 6: SOLD AGAIN --------
              notificationCard(
                icon: Icons.tv,
                color: Colors.grey,
                title: "Sky News Arabia اشترت فيديو",
                subtitle: "تم الدفع",
                trailing: badge("+\$600", Colors.green),
              ),

              /// -------- 7: REJECTED --------
              notificationCard(
                icon: Icons.block,
                color: Colors.red,
                title: "تم رفض محتوى",
                subtitle: "السبب: جودة منخفضة",
                trailing: badge("مرفوض", Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// CARD TEMPLATE
  static Widget notificationCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    Widget? trailing,
    Widget? actions,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// TOP ROW
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ICON BOX
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color),
              ),

              const SizedBox(width: 10),

              /// TEXT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),

              /// TRAILING
              // ignore: use_null_aware_elements
              if (trailing != null) trailing,
            ],
          ),

          /// ACTIONS
          if (actions != null) ...[const SizedBox(height: 12), actions],
        ],
      ),
    );
  }

  /// BADGE
  static Widget badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 12)),
    );
  }

  /// OUTLINED BUTTON
  static Widget outlinedBtn(String text) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {},
      child: Text(text),
    );
  }

  /// FILLED BUTTON
  static Widget filledBtn(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {},
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}

/// BOTTOM NAV

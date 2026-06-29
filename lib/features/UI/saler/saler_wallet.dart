import 'package:flutter/material.dart';

class SalerWalletScreen extends StatelessWidget {
  const SalerWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: const BoxDecoration(color: Colors.black),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    const Text(
                      "محفظتي",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Center(
                      child: Column(
                        children: [
                          Text(
                            "الرصيد المتاح للسحب",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "\$2,100",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 42,
                            ),
                          ),
                          Text(
                            "+ \$420 هذا الأسبوع",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    Row(
                      children: [
                        Expanded(
                          child: _statCard(
                            title: "إجمالي الأرباح",
                            value: "\$11,420",
                            subTitle: "منذ الانضمام",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _statCard(
                            title: "رصيد معلق",
                            value: "\$1,150",
                            subTitle: "قيد التحقق",
                            subColor: Colors.orange,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: _statCard(
                            title: "متوسط الصفقة",
                            value: "\$490",
                            subTitle: "أفضل %85",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _statCard(
                            title: "هذا الشهر",
                            value: "\$1,680",
                            subTitle: "8 صفقات",
                            valueColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// CONTENT
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(color: Color(0xffF3F3F3)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "السحب والتحويل",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E4F8A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          "طلب السحب",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                      children: const [
                        _PaymentCard(
                          title: "PayPal",
                          subtitle: "خلال 24 ساعة",
                          icon: Icons.payment,
                        ),
                        _PaymentCard(
                          title: "تحويل بنكي",
                          subtitle: "SWIFT · IBAN",
                          icon: Icons.account_balance,
                        ),
                        _PaymentCard(
                          title: "Wise",
                          subtitle: "رسوم منخفضة",
                          icon: Icons.phone_android,
                        ),
                        _PaymentCard(
                          title: "Crypto",
                          subtitle: "USDT · BTC",
                          icon: Icons.currency_bitcoin,
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Row(
                            children: [
                              _FilterChip(text: "سنة"),
                              SizedBox(width: 8),
                              _FilterChip(text: "شهر"),
                              SizedBox(width: 8),
                              _FilterChip(text: "أسبوع", selected: true),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "الأرباح الشهرية",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "\$1,680+ إجمالي",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          SizedBox(
                            height: 180,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _bar(140),
                                _bar(100),
                                _bar(55),
                                _bar(85),
                                _bar(48),
                                _bar(55),
                                _bar(40),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Text(
                                  "عرض الكل",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "سجل المعاملات",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Divider(),

                          _transaction(
                            "+ \$850",
                            "قناة الجزيرة",
                            "غزة",
                            Colors.green,
                          ),
                          _transaction(
                            "+ \$420",
                            "قناة العربية",
                            "غزة",
                            Colors.green,
                          ),
                          _transaction(
                            "+ \$310",
                            "Reuters",
                            "غزة",
                            Colors.green,
                          ),
                          _transaction("- \$500", "PayPal", "سحب", Colors.red),
                          _transaction(
                            "+ \$850",
                            "Sky News",
                            "غزة",
                            Colors.green,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _bar(double height) {
    return Container(
      width: 35,
      height: height,
      decoration: BoxDecoration(
        color: Color(0xff3F4C8F),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  static Widget _transaction(
    String amount,
    String source,
    String place,
    Color color,
  ) {
    return ListTile(
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      title: Text("$source — $place", textAlign: TextAlign.right),
      subtitle: const Text("منذ يومين", textAlign: TextAlign.right),
      trailing: Text(
        amount,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  static Widget _statCard({
    required String title,
    required String value,
    required String subTitle,
    Color valueColor = Colors.white,
    Color subColor = Colors.white70,
  }) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.15),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 6),
          Text(subTitle, style: TextStyle(color: subColor, fontSize: 12)),
        ],
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _PaymentCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 35),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Text(subtitle),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String text;
  final bool selected;

  const _FilterChip({required this.text, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? Colors.grey.shade300 : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black26),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

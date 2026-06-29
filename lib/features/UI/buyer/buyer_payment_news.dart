import 'package:flutter/material.dart';

class BuyerPaymentScreen extends StatefulWidget {
  const BuyerPaymentScreen({super.key});

  @override
  State<BuyerPaymentScreen> createState() => _BuyerPaymentScreenState();
}

class _BuyerPaymentScreenState extends State<BuyerPaymentScreen> {
  int selectedMethod = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              // Header
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black26)),
                ),
                child: Row(
                  children: [
                    const Text(
                      "أمن",
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                    const Spacer(),
                    const Text(
                      "اتمام الدفع",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "ملخص الطلب",
                          style: TextStyle(fontSize: 28),
                        ),
                      ),

                      const SizedBox(height: 12),

                      _buildOrderSummary(),

                      const SizedBox(height: 24),

                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "طريقة الدفع",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),

                      const SizedBox(height: 16),

                      _paymentMethod(
                        index: 0,
                        title: "بطاقة بنكية",
                        subtitle: "Visa · Mastercard · Amex",
                        icon: Icons.credit_card,
                      ),

                      _paymentMethod(
                        index: 1,
                        title: "Apple pay",
                        subtitle: "دفع سريع بالبصمة",
                        icon: Icons.phone_iphone,
                      ),

                      _paymentMethod(
                        index: 2,
                        title: "تحويل بنكي",
                        subtitle: "SWIFT · IBAN خلال 24 ساعة",
                        icon: Icons.account_balance,
                      ),

                      _paymentMethod(
                        index: 3,
                        title: "PayPal",
                        subtitle: "دفع فوري مضمون",
                        icon: Icons.paypal,
                      ),

                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: OutlinedButton(
                          onPressed: () {
                            // Save payment details
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            "ادفع الان",
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffE9E1DC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xffBC8F72)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  "https://picsum.photos/200",
                  width: 95,
                  height: 75,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "لحظة قصف احد المباني في مدينة غزة",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "فيديو 2:40 · 4K · أنس خالد شبات",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Divider(height: 28),

          _priceRow("سعر المحتوى", "\$${data["price"]}"),
          _priceRow("رسوم المنصة (5%)", "\$42.00"),
          _priceRow("ضريبة القيمة المضافة", "\$0.00"),

          const Divider(height: 28),

          Row(
            children: [
              Text(
                "\$${data["price"]}",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              Spacer(),
              Text(
                "الإجمالي",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(value, style: const TextStyle(fontSize: 18)),
          const Spacer(),
          Text(title, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  Widget _paymentMethod({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final selected = selectedMethod == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? Colors.red : Colors.black26,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? Colors.red : Colors.grey,
                  width: 2,
                ),
              ),
              child: selected
                  ? const Center(
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: Colors.red,
                      ),
                    )
                  : null,
            ),

            const Spacer(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title, style: const TextStyle(fontSize: 24)),
                Text(subtitle, style: const TextStyle(color: Colors.black54)),
              ],
            ),

            const SizedBox(width: 12),

            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon),
            ),
          ],
        ),
      ),
    );
  }
}

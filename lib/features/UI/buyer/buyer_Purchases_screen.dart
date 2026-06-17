import 'package:flutter/material.dart';

class BuyerPurchasesScreen extends StatelessWidget {
  const BuyerPurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              /// HEADER
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: const [
                    Text(
                      "المشتريات",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    Text("2026", style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),

              const Divider(),

              /// TABS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  TabItem("الكل", true),
                  TabItem("هذا الشهر", false),
                  TabItem("حصري", false),
                ],
              ),

              const Divider(),

              /// STATS
              Container(
                color: const Color(0xffE6D9C5),
                child: Row(
                  children: const [
                    StatBox("12", "مشتريات"),
                    StatBox("\$8,500", "إجمالي"),
                    StatBox("5", "حصري"),
                  ],
                ),
              ),

              /// LIST
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: const [
                    PurchaseCard(),
                    SizedBox(height: 16),
                    PurchaseCard(),
                    SizedBox(height: 16),
                    PurchaseCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// TAB
class TabItem extends StatelessWidget {
  final String text;
  final bool active;

  const TabItem(this.text, this.active, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            color: active ? Colors.red : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        if (active) Container(width: 30, height: 3, color: Colors.red),
      ],
    );
  }
}

/// STAT BOX
class StatBox extends StatelessWidget {
  final String value;
  final String label;

  const StatBox(this.value, this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: Colors.black12)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(label, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

/// PURCHASE CARD
class PurchaseCard extends StatelessWidget {
  const PurchaseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          /// TOP CONTENT
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                /// IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1549887534-3db5c71c3d0b",
                    width: 90,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 10),

                /// TEXT CONTENT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        "لحظة قصف احد المباني في مدينة غزة",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "فلسطين - غزة • فيديو 4K • حصري",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "16 - يناير - 2026",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                /// PRICE
                Column(
                  children: const [
                    Text(
                      "\$850",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text("مكتمل", style: TextStyle(color: Colors.green)),
                  ],
                ),
              ],
            ),
          ),

          const Divider(),

          /// ACTIONS
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                OutlinedButton(onPressed: () {}, child: const Text("مشاركة")),
                const SizedBox(width: 8),
                OutlinedButton(onPressed: () {}, child: const Text("فاتورة")),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "تحميل",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BuyerPreferredScreen extends StatelessWidget {
  const BuyerPreferredScreen({super.key});

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
                      "المفضلة",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text("7 محفوظات", style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),

              const Divider(),

              /// TABS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    tabItem("الكل", true),
                    tabItem("فيديو", false),
                    tabItem("صور", false),
                    tabItem("حصري", false),
                  ],
                ),
              ),

              const Divider(),

              /// STATS
              Container(
                color: const Color(0xffE6D9C5),
                child: Row(
                  children: const [
                    statBox("\$3,240", "إجمالي"),
                    statBox("3", "حصري"),
                    statBox("7", "محفوظات"),
                  ],
                ),
              ),

              /// LIST
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: const [
                    FavoriteCard(),
                    SizedBox(height: 16),
                    FavoriteCard(),
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
class tabItem extends StatelessWidget {
  final String text;
  final bool active;

  const tabItem(this.text, this.active, {super.key});

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
class statBox extends StatelessWidget {
  final String value;
  final String label;

  const statBox(this.value, this.label, {super.key});

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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(label, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

/// FAVORITE CARD
class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffE6D9C5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              "https://images.unsplash.com/photo-1549887534-3db5c71c3d0b",
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /// LOCATION
                const Text("فلسطين - غزة", style: TextStyle(color: Colors.red)),

                const SizedBox(height: 6),

                /// TITLE
                const Text(
                  "لحظة قصف احد المباني في مدينة غزة",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                /// FOOTER
                Row(
                  children: [
                    /// DELETE
                    OutlinedButton(onPressed: () {}, child: const Text("حذف")),

                    const SizedBox(width: 8),

                    /// BUY BUTTON
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text("شراء 850\$"),
                    ),

                    const Spacer(),

                    const Text("فلسطين - منذ 12 د"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

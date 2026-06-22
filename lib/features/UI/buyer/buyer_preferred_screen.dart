import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khabar/core/routing/routes.dart';

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
                    Text(
                      "10 محفوظات",
                      style: TextStyle(color: Color.fromARGB(255, 0, 42, 77)),
                    ),
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
                    TabItem("الكل", true),
                    TabItem("فيديو", false),
                    TabItem("صور", false),
                  ],
                ),
              ),

              const Divider(),

              /// STATS
              Container(
                color: const Color.fromARGB(255, 197, 210, 230),
                child: Row(
                  children: const [
                    StatBox("\$3,240", "إجمالي"),
                    StatBox("3", "حصري"),
                    StatBox("7", "محفوظات"),
                  ],
                ),
              ),

              Expanded(
                child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('newsupload')
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: Text("لا توجد بيانات"));
                    }

                    final docs = (snapshot.data as QuerySnapshot).docs.toList();

                    docs.shuffle();

                    final randomDocs = docs.take(10).toList();

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: randomDocs.length,
                      itemBuilder: (context, index) {
                        final data =
                            randomDocs[index].data() as Map<String, dynamic>;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: FavoriteCard(data: data),
                        );
                      },
                    );
                  },
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
            color: active ? Color.fromARGB(255, 0, 42, 77) : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        if (active)
          Container(
            width: 30,
            height: 3,
            color: Color.fromARGB(255, 0, 42, 77),
          ),
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: const TextStyle(color: Color.fromARGB(255, 192, 200, 243)),
            ),
          ],
        ),
      ),
    );
  }
}

/// FAVORITE CARD
class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 197, 210, 230),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// IMAGE
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                data['image'] ?? '',
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/logo.png",
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data['region'] ?? '',
                  style: const TextStyle(color: Colors.red),
                ),

                const SizedBox(height: 6),

                Text(
                  data['title'] ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                // FOOTER
                Row(
                  children: [
                    const SizedBox(width: 8),
                    // BUY BUTTON
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.buyerdetailsScreen,
                          arguments: data,
                        );
                      },

                      child: Text(
                        "شراء ${data['price'] ?? 0}\$",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),

                    const Spacer(),

                    Text(
                      data['createdAt'] != null
                          ? (data['createdAt'] as Timestamp)
                                .toDate()
                                .toString()
                                .substring(0, 10)
                          : '',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
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

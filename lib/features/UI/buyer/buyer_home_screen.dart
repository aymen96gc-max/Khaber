import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({super.key});

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  String? name;

  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection("buyers")
          .doc(user.uid)
          .get();

      setState(() {
        name = doc['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// HEADER WITH GRADIENT
                Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff3F4C8F), Color(0xff5663C1)],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Text(
                                "مرحباً، ${name ?? ""}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          /// SEARCH BOX
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade700,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.search, color: Colors.white70),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "ابحث عن خبر أو حدث أو منطقة...",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// RED BREAKING BAR
                Container(
                  width: double.infinity,
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: const Text(
                    "عاجل",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 10),

                /// TOP NEWS CARDS
                SizedBox(
                  height: 190,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: const [
                      SizedBox(width: 10),
                      NewsCard(),
                      SizedBox(width: 10),
                      NewsCard(),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                /// REGION FILTER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      chip("الكل", true),
                      chip("تركيا", false),
                      chip("اليمن", false),
                      chip("العراق", false),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                /// LATEST CONTENT TITLE
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text("عرض الكل", style: TextStyle(color: Colors.red)),
                      Spacer(),
                      Text(
                        "أحدث المحتوى",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// LIST ITEMS
                const ContentItem(),
                const ContentItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// NEWS CARD (TOP)
class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: Stack(
              children: [
                Image.network(
                  "https://images.unsplash.com/photo-1519681393784-d120267933ba",
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                const Positioned(
                  right: 8,
                  top: 8,
                  child: Chip(label: Text("عاجل"), backgroundColor: Colors.red),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text("قناة الجزيرة", style: TextStyle(color: Colors.red)),
                SizedBox(height: 4),
                Text("حزام ناري بمدينة قطاع غزة"),
                SizedBox(height: 6),
                Row(children: [Text("12 د"), Spacer(), Text("\$850")]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// CONTENT LIST ITEM
class ContentItem extends StatelessWidget {
  const ContentItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "https://images.unsplash.com/photo-1504711434969-e33886168f5c",
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 10),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text("قطاع غزة", style: TextStyle(color: Colors.red)),
                const SizedBox(height: 4),
                const Text("اشتباكات في شمال القطاع"),
                const SizedBox(height: 8),

                Row(
                  children: const [
                    Text("\$650"),
                    SizedBox(width: 10),
                    OutlinedButton(onPressed: null, child: Text("شراء")),
                    Spacer(),
                    Text("أنس خ • 4.9 ⭐ "),
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

/// CHIP
Widget chip(String text, bool active) {
  return Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: active ? Colors.red : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: Text(
        text,
        style: TextStyle(color: active ? Colors.white : Colors.black),
      ),
    ),
  );
}

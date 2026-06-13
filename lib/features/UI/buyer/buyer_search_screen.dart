import 'package:flutter/material.dart';

class BuyerSearchScreen extends StatelessWidget {
  const BuyerSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              /// HEADER + SEARCH
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.arrow_forward_ios, size: 18),
                        SizedBox(width: 8),
                        Text(
                          "بحث",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    /// SEARCH BAR
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "ابحث عن خبر أو منطقة...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Icon(Icons.mic, color: Colors.grey),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// FILTERS
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    chip("الكل", true),
                    chip("فيديو", false),
                    chip("صور", false),
                    chip("غزة", false),
                    chip("سوريا", false),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// RECENT SEARCH
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Text("مسح الكل", style: TextStyle(color: Colors.red)),
                    Spacer(),
                    Text(
                      "عمليات البحث الأخيرة",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              Wrap(
                spacing: 8,
                children: [
                  recentItem("غزة"),
                  recentItem("حروب"),
                  recentItem("سوريا"),
                ],
              ),

              const SizedBox(height: 12),

              /// RESULTS
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: const [
                    SearchItem(),
                    SizedBox(height: 14),
                    SearchItem(),
                    SizedBox(height: 14),
                    SearchItem(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// CHIP FILTER
  static Widget chip(String text, bool active) {
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

  /// RECENT ITEM
  static Widget recentItem(String text) {
    return Chip(label: Text(text), onDeleted: () {});
  }
}

/// SEARCH RESULT ITEM
class SearchItem extends StatelessWidget {
  const SearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// IMAGE
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            "https://images.unsplash.com/photo-1504711434969-e33886168f5c",
            width: 100,
            height: 90,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(width: 10),

        /// DETAILS
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text("قطاع غزة", style: TextStyle(color: Colors.red)),

              SizedBox(height: 4),

              Text(
                "اشتباكات عنيفة في شمال القطاع",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 6),

              Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: Colors.grey),
                  SizedBox(width: 4),
                  Text("منذ ساعتين", style: TextStyle(color: Colors.grey)),
                  Spacer(),
                  Icon(Icons.location_on, size: 14, color: Colors.red),
                  SizedBox(width: 4),
                  Text("فلسطين", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(width: 10),

        /// PRICE + BUTTON
        Column(
          children: [
            const Text("\$650", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            OutlinedButton(onPressed: () {}, child: const Text("شراء")),
          ],
        ),
      ],
    );
  }
}

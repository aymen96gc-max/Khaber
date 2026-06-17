import 'package:flutter/material.dart';

class SalerContentScreen extends StatelessWidget {
  const SalerContentScreen({super.key});

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
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "⚡ محتوى",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              /// TABS
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    TabItem("الكل (14)", true),
                    TabItem("مباع (5)", false),
                    TabItem("مشاهدات (55)", false),
                    TabItem("أرباح (\$255)", false),
                  ],
                ),
              ),

              /// SEARCH
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "ابحث عن محتواك ...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              /// LIST
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    ContentCard(),
                    SizedBox(height: 16),
                    ContentCard(),
                    SizedBox(height: 16),
                    ContentCard(),
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
            color: active ? Colors.red : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        if (active) Container(width: 30, height: 3, color: Colors.red),
      ],
    );
  }
}

/// CONTENT CARD
class ContentCard extends StatelessWidget {
  const ContentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        /// IMAGE + OVERLAY
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                "https://images.unsplash.com/photo-1544006659-f0b21884ce1d",
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            /// Play button
            const Positioned.fill(
              child: Center(
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.play_arrow, color: Colors.white, size: 28),
                ),
              ),
            ),

            /// top labels
            Positioned(
              top: 10,
              right: 10,
              child: Row(
                children: [
                  Label("حصري", Colors.red),
                  const SizedBox(width: 6),
                  Label("مباع", Colors.green),
                ],
              ),
            ),

            /// duration
            Positioned(bottom: 8, left: 8, child: SmallTag("5:10")),

            /// views
            Positioned(bottom: 8, right: 8, child: SmallTag("200")),
          ],
        ),

        const SizedBox(height: 10),

        /// TITLE + DETAILS
        const Text("حروب وصراعات", style: TextStyle(color: Colors.red)),
        const SizedBox(height: 4),

        const Text(
          "قصف عنيف في جميع أنحاء القطاع",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 6),

        Row(
          children: const [
            Icon(Icons.location_on, size: 16, color: Colors.red),
            Text("غزة، فلسطين"),
            Spacer(),
            Icon(Icons.access_time, size: 16, color: Colors.blue),
            Text(" منذ يومين"),
            Spacer(),
            Icon(Icons.tv, size: 16),
            Text(" الجزيرة"),
          ],
        ),

        const SizedBox(height: 12),

        /// ACTIONS
        Row(
          children: [
            const Icon(Icons.more_horiz),
            const SizedBox(width: 10),

            OutlinedButton(onPressed: () {}, child: const Text("رفع السعر")),

            const SizedBox(width: 10),

            OutlinedButton(onPressed: () {}, child: const Text("تعديل")),

            const Spacer(),

            const Text(
              "\$ 850",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

/// LABEL
class Label extends StatelessWidget {
  final String text;
  final Color color;
  const Label(this.text, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

/// SMALL TAG
class SmallTag extends StatelessWidget {
  final String text;
  const SmallTag(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}

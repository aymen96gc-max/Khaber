import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khabar/core/helper/firebase_sarvices_product.dart';
import 'package:flutter/material.dart';
import 'package:khabar/features/UI/buyer/buyer_purchases_screen.dart';


class SalerContentScreen extends StatefulWidget {
  const SalerContentScreen({super.key});

  @override
  State<SalerContentScreen> createState() => _SalerContentScreenState();
}

class _SalerContentScreenState extends State<SalerContentScreen> {
  final ProductService productService = ProductService();

  List<DocumentSnapshot> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final docs = await productService.fetchProducts();

    setState(() {
      products = docs;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
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

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    TabItem("الكل", true),
                    TabItem("مباع", false),
                    TabItem("مشاهدات", false),
                    TabItem("أرباح", false),
                  ],
                ),
              ),

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

              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final data =
                              products[index].data() as Map<String, dynamic>;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: ContentCard(data: data),
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

class ContentCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const ContentCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                data["image"] ?? "",
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    height: 170,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image, size: 50),
                  );
                },
              ),
            ),

            if (data["type"] == "video")
              const Positioned.fill(
                child: Center(
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.black54,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),

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

            Positioned(bottom: 8, left: 8, child: SmallTag(data["type"] ?? "")),

            Positioned(
              bottom: 8,
              right: 8,
              child: SmallTag(data["region"] ?? ""),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Text(data["region"] ?? "", style: const TextStyle(color: Colors.red)),

        const SizedBox(height: 4),

        Text(
          data["title"] ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 6),

        Row(
          children: [
            const Icon(Icons.location_on, size: 16, color: Colors.red),
            Text(data["region"] ?? ""),

            const Spacer(),

            const Icon(Icons.access_time, size: 16, color: Colors.blue),

            Text(
              data["createdAt"] != null
                  ? (data["createdAt"] as Timestamp)
                        .toDate()
                        .toString()
                        .substring(0, 10)
                  : "",
            ),

            const Spacer(),

            const Icon(Icons.tv, size: 16),

            Text(data["type"] ?? ""),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            const Icon(Icons.more_horiz),

            const SizedBox(width: 10),

            OutlinedButton(onPressed: () {}, child: const Text("رفع السعر")),

            const SizedBox(width: 10),

            OutlinedButton(onPressed: () {}, child: const Text("تعديل")),

            const Spacer(),

            Text(
              "\$${data["price"] ?? 0}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
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

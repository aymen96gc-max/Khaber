import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:khabar/core/helper/firebase_sarvices_product.dart';
import 'package:khabar/core/helper/firebase_sarvices_user.dart';
import 'package:khabar/core/helper/video_preview.dart';
import 'package:khabar/core/routing/routes.dart';

class BuyerPurchasesScreen extends StatefulWidget {
  const BuyerPurchasesScreen({super.key});

  @override
  State<BuyerPurchasesScreen> createState() => _BuyerPurchasesScreenState();
}

class _BuyerPurchasesScreenState extends State<BuyerPurchasesScreen> {
  final UserService userService = UserService();
  final ProductService productService = ProductService();

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
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.buyerhomeSwitcher);
                      },
                      icon: const Icon(Icons.arrow_back_ios, size: 18),
                      label: const Text(" "),
                    ),
                    const Text(
                      "مشترياتي",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  TabItem("الكل", true),
                  TabItem("هذا الشهر", false),
                  TabItem("حصري", false),
                ],
              ),

              const Divider(),

              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("orders")
                      .where("buyerId", isEqualTo: userService.currentUser!.uid)
                      .snapshots(),
                  builder: (context, orderSnapshot) {
                    if (!orderSnapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final orders = orderSnapshot.data!.docs;

                    double totalAmount = 0;

                    for (var order in orders) {
                      final data = order.data() as Map<String, dynamic>;

                      totalAmount += (data["price"] as num?)?.toDouble() ?? 0;
                    }

                    if (orders.isEmpty) {
                      return const Center(child: Text("لا توجد مشتريات"));
                    }

                    return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order =
                            orders[index].data() as Map<String, dynamic>;

                        return PurchaseCard(data: order);
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

class PurchaseCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const PurchaseCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: data['fileType'] == "video"
                      ? SizedBox(
                          height: 90,
                          width: 80,
                          child: VideoPreview(videoUrl: data['fileUrl']),
                        )
                      : Image.network(
                          data['fileUrl'] ?? '',
                          width: 90,
                          height: 80,
                          fit: BoxFit.cover,

                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/news.jpg",
                              width: 90,
                              height: 80,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        data["title"] ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "${data["region"] ?? ""} • ${data["fileType"] ?? ""}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        data["createdAt"] != null
                            ? (data["createdAt"] as Timestamp)
                                  .toDate()
                                  .toString()
                                  .substring(0, 10)
                            : "",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                Column(
                  children: [
                    Text(
                      "\$${data["price"] ?? 0}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text("مكتمل", style: TextStyle(color: Colors.green)),
                  ],
                ),
              ],
            ),
          ),

          const Divider(),

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
                  onPressed: () {
                    final fileUrl = data["fileUrl"];

                    if (fileUrl == null || fileUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("لا يوجد ملف للتحميل")),
                      );
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("بدأ التحميل...")),
                    );

                    FileDownloader.downloadFile(
                      url: fileUrl,
                      onDownloadCompleted: (path) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("✅ تم تحميل الملف بنجاح")),
                        );
                      },
                      onDownloadError: (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("فشل التحميل: $error")),
                        );
                      },
                    );
                  },
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khabar/core/helper/firebase_sarvices_product.dart';
import 'package:khabar/core/helper/firebase_sarvices_user.dart';
import 'package:khabar/core/helper/video_preview.dart';
import 'package:khabar/core/routing/routes.dart';
import 'package:khabar/features/UI/buyer/buyer_search_screen.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({super.key});

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  String? name;
  String selectedRegion = "الكل";

  final UserService userService = UserService();
  final ProductService productService = ProductService();
  List<DocumentSnapshot> products = [];
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    fetchUser();
    loadProducts();
  }

  Future<void> loadProducts() async {
    final docs = await fetchProducts();

    print("Loaded: ${docs.length}");

    setState(() {
      products = docs;
    });
  }

  Future<void> fetchUser() async {
    final userName = await userService.fetchUserName();

    if (userName != null) {
      setState(() {
        name = userName;
      });
    }
  }

  Future<List<DocumentSnapshot>> fetchProducts({String? region}) async {
    try {
      Query query = FirebaseFirestore.instance
          .collection('newsupload')
          .where('isSold', isEqualTo: false);

      if (region != null && region != "الكل") {
        query = query.where('region', isEqualTo: region);
      }

      final snapshot = await query.get();

      for (var doc in snapshot.docs) {
        print(doc.data());
      }

      return snapshot.docs;
    } catch (e) {
      print("ERROR => $e");
      return [];
    }
  }

  Widget buildChip(String text) {
    final isActive = selectedRegion == text;

    return GestureDetector(
      onTap: () async {
        setState(() {
          selectedRegion = text;
          products.clear();
          hasMore = true;
        });

        productService.resetPagination();

        final docs = await fetchProducts(region: selectedRegion);
        setState(() {
          products.addAll(docs);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.red : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(color: isActive ? Colors.white : Colors.black),
        ),
      ),
    );
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
              /// HEADER
              Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff3F4C8F), Color(0xff5663C1)],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "مرحباً، ${name ?? ""}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  onSubmitted: (value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BuyerSearchScreen(
                                          searchText: value,
                                          products: products,
                                        ),
                                      ),
                                    );
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ),
                                    hintText: "ابحث...",
                                    hintStyle: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
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

              /// عاجل
              Container(
                width: double.infinity,
                color: Colors.red,
                padding: const EdgeInsets.all(8),
                child: const Text(
                  "عاجل",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final data = products[index].data() as Map<String, dynamic>;

                    return Container(
                      width: 260,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: data['fileType'] == "video"
                                  ? SizedBox(
                                      height: 320,
                                      width: double.infinity,
                                      child: VideoPreview(
                                        videoUrl: data['fileUrl'],
                                      ),
                                    )
                                  : Image.network(
                                      data['fileUrl'] ?? '',
                                      width: double.infinity,
                                      height: 320,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/news.jpg',
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                    ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              data['title'] ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                              right: 8,
                              left: 8,
                              bottom: 8,
                            ),
                            child: Text(
                              data['region'] ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildChip("الكل"),
                    buildChip("غزة"),
                    buildChip("سوريا"),
                    buildChip("مصر"),
                    buildChip("الأردن"),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// العنوان
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

              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final data = products[index].data() as Map<String, dynamic>;

                    return ContentItemDynamic(data: data);
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

class ContentItemDynamic extends StatelessWidget {
  final Map<String, dynamic> data;

  const ContentItemDynamic({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                data['fileUrl'],
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/news.jpg',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  );
                },
              ),

              if (data['fileType'] == 'video')
                const Icon(Icons.play_circle, size: 40, color: Colors.white),
            ],
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data['region'] ?? '',
                  style: const TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
                ),
                const SizedBox(height: 4),
                Text(data['title'] ?? ''),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text("\$${data['price'] ?? 0}"),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.buyerdetailsScreen,
                          arguments: data,
                        );
                      },
                      child: const Text("شراء"),
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

/// NEWS CARD
class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(left: 10),
      color: Colors.white,
      child: const Center(child: Text("Top News")),
    );
  }
}

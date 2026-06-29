import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khabar/core/helper/video_preview.dart';
import 'package:khabar/core/routing/routes.dart';

class BuyerSearchScreen extends StatefulWidget {
  final String searchText;
  final List<DocumentSnapshot> products;

  const BuyerSearchScreen({
    super.key,
    required this.searchText,
    required this.products,
  });

  @override
  State<BuyerSearchScreen> createState() => _BuyerSearchScreenState();
}

class _BuyerSearchScreenState extends State<BuyerSearchScreen> {
  late String searchText;
  final TextEditingController searchController = TextEditingController();
  List<DocumentSnapshot> allProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    searchText = widget.searchText;
    searchController.text = widget.searchText;
    allProducts = widget.products;
    _loadProductsIfNeeded();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _loadProductsIfNeeded() async {
    if (allProducts.isNotEmpty) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('newsupload')
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get();

    setState(() {
      allProducts = snapshot.docs;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final results = allProducts.where((doc) {
      final data = doc.data() as Map<String, dynamic>;

      final title = (data['title'] ?? '').toString().toLowerCase();
      final description = (data['description'] ?? '').toString().toLowerCase();
      final region = (data['region'] ?? '').toString().toLowerCase();

      final queryWords = searchText.toLowerCase().trim().split(RegExp(r'\s+'));

      return queryWords.any((word) => title.contains(word)) ||
          queryWords.any((word) => description.contains(word)) ||
          queryWords.any((word) => region.contains(word));
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("البحث")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: const InputDecoration(
                hintText: "ابحث...",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : results.isEmpty
                ? const Center(child: Text("لا توجد نتائج"))
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final data =
                          results[index].data() as Map<String, dynamic>;

                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.buyerdetailsScreen,
                            arguments: data,
                          );
                        },

                        leading: data['fileType'] == "video"
                            ? SizedBox(
                                height: 320,
                                width: double.infinity,
                                child: VideoPreview(videoUrl: data['fileUrl']),
                              )
                            : Image.network(
                                data['fileUrl'] ?? '',
                                width: double.infinity,
                                height: 320,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    "assets/images/news.jpg",
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                        title: Text(data['title'] ?? ''),
                        subtitle: Text(data['region'] ?? ''),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

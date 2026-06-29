import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:khabar/core/helper/video_preview.dart';

class SalerContentScreen extends StatefulWidget {
  const SalerContentScreen({super.key});

  @override
  State<SalerContentScreen> createState() => _SalerContentScreenState();
}

class _SalerContentScreenState extends State<SalerContentScreen> {
  String searchText = '';
  @override
  void initState() {
    super.initState();
  }

  Stream<QuerySnapshot> get userContentStream {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    return FirebaseFirestore.instance
        .collection('newsupload')
        .where('sallerId', isEqualTo: user.uid)
        .snapshots();
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
                  onChanged: (value) {
                    setState(() {
                      searchText = value.trim();
                    });
                  },
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
                child: StreamBuilder<QuerySnapshot>(
                  stream: userContentStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text('خطأ في التحميل: ${snapshot.error}'),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("لا يوجد محتوى"));
                    }
                    final filteredDocs = snapshot.data!.docs.where((doc) {
                      final data = doc.data() as Map<String, dynamic>;

                      final title = (data["title"] ?? "")
                          .toString()
                          .toLowerCase();

                      final region = (data["region"] ?? "")
                          .toString()
                          .toLowerCase();

                      final description = (data["description"] ?? "")
                          .toString()
                          .toLowerCase();
                      final searchText = this.searchText.toLowerCase();

                      return title.contains(searchText) ||
                          region.contains(searchText) ||
                          description.contains(searchText);
                    }).toList();

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredDocs.length,
                      itemBuilder: (context, index) {
                        final doc = filteredDocs[index];
                        final data = doc.data() as Map<String, dynamic>;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ContentCard(data: data, docId: doc.id),
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

class ContentCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final String docId;

  const ContentCard({super.key, required this.data, required this.docId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: data['fileType'] == "video"
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
                          'assets/images/news.jpg',
                          width: double.infinity,
                          height: 320,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
            ),

            if (data["fileType"] == "video")
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
                  if (data["isSold"] == true) Label("مباع", Colors.green),
                ],
              ),
            ),

            Positioned(
              bottom: 12,
              left: 12,
              child: SmallTag(data["fileType"] ?? ""),
            ),

            Positioned(
              bottom: 12,
              right: 12,
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

            Text(data["fileType"] ?? ""),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            OutlinedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    final controller = TextEditingController(
                      text: data["price"].toString(),
                    );

                    return AlertDialog(
                      title: const Text("تعديل السعر"),
                      content: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("إلغاء"),
                        ),

                        ElevatedButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection("newsupload")
                                .doc(docId)
                                .update({
                                  "price":
                                      double.tryParse(controller.text) ?? 0,
                                });

                            Navigator.pop(context);
                          },
                          child: const Text("حفظ"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("تعديل السعر"),
            ),

            const SizedBox(width: 6),

            OutlinedButton(
              onPressed: () {
                final titleController = TextEditingController(
                  text: data["title"] ?? '',
                );

                final descriptionController = TextEditingController(
                  text: data["description"] ?? '',
                );

                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text("تعديل الخبر"),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: titleController,
                              decoration: const InputDecoration(
                                labelText: "العنوان",
                              ),
                            ),

                            const SizedBox(height: 12),

                            TextField(
                              controller: descriptionController,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                labelText: "الوصف",
                              ),
                            ),

                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("إلغاء"),
                        ),

                        ElevatedButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection("newsupload")
                                .doc(docId)
                                .update({
                                  "title": titleController.text.trim(),
                                  "description": descriptionController.text
                                      .trim(),
                                });

                            Navigator.pop(context);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("✅ تم تحديث الخبر")),
                            );
                          },
                          child: const Text("حفظ"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("تعديل"),
            ),
            const SizedBox(width: 6),

            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                final imageUrl = data["fileUrl"] ?? '';
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("حذف الخبر"),
                    content: const Text("هل أنت متأكد؟"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("إلغاء"),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("حذف"),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  await FirebaseStorage.instance.refFromURL(imageUrl).delete();

                  await FirebaseFirestore.instance
                      .collection("newsupload")
                      .doc(docId)
                      .delete();
                }
              },
            ),

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

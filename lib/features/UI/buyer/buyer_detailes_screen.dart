import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khabar/core/helper/video_preview.dart';

class BuyerDetailsScreen extends StatefulWidget {
  const BuyerDetailsScreen({super.key});

  static const String views = "15,000 مشاهدة";
  static const String quality = "4K - 2:40";

  @override
  State<BuyerDetailsScreen> createState() => _BuyerDetailsScreenState();

  static Widget _infoCard(String title, dynamic value) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Color.fromARGB(170, 197, 210, 230),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          const SizedBox(height: 10),
          Text(value.toString(), style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class _BuyerDetailsScreenState extends State<BuyerDetailsScreen> {
  bool isLoading = false;
  bool isPurchased = false;

  Future<void> buyContent() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final buyer = FirebaseAuth.instance.currentUser;

      if (buyer == null) return;

      final data =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      final docId = data["docId"];
      final sallerId = data["sallerId"];
      final price = (data["price"] as num).toDouble();

      final buyerRef = FirebaseFirestore.instance
          .collection("buyers")
          .doc(buyer.uid);

      final sallerRef = FirebaseFirestore.instance
          .collection("salers")
          .doc(sallerId);

      final contentRef = FirebaseFirestore.instance
          .collection("newsupload")
          .doc(docId);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final buyerSnap = await transaction.get(buyerRef);
        final sallerSnap = await transaction.get(sallerRef);
        final contentSnap = await transaction.get(contentRef);

        if (!buyerSnap.exists) {
          throw Exception("حساب المشتري غير موجود");
        }

        if (!sallerSnap.exists) {
          throw Exception("حساب البائع غير موجود");
        }

        if (!contentSnap.exists) {
          throw Exception("المحتوى غير موجود");
        }

        if (buyer.uid == sallerId) {
          throw Exception("لا يمكنك شراء محتواك");
        }

        double buyerBalance = (buyerSnap["balance"] as num).toDouble();

        if (buyerBalance < price) {
          throw Exception("رصيد غير كاف");
        }

        bool sold = contentSnap["isSold"] ?? false;

        if (sold) {
          throw Exception("تم بيع المحتوى مسبقاً");
        }

        double sallerBalance = (sallerSnap["balance"] as num).toDouble();

        transaction.update(buyerRef, {"balance": buyerBalance - price});

        transaction.update(sallerRef, {"balance": sallerBalance + price});

        transaction.update(contentRef, {
          "isSold": true,
          "buyerId": buyer.uid,
          "soldAt": FieldValue.serverTimestamp(),
        });
      });

      await FirebaseFirestore.instance.collection("orders").add({
        "buyerId": buyer.uid,
        "sallerId": sallerId,
        "contentId": docId,
        "title": data["title"],
        "fileUrl": data["fileUrl"],
        "fileType": data["fileType"],
        "region": data["region"],
        "price": price,
        "status": "completed",
        "createdAt": FieldValue.serverTimestamp(),
      });

      setState(() {
        isPurchased = true;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("تم الشراء بنجاح ✅")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null) {
      return const Scaffold(body: Center(child: Text('لا توجد بيانات')));
    }

    final data = args as Map<String, dynamic>;
    final bool isSold = isPurchased || (data['isSold'] ?? false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// IMAGE
                Stack(
                  children: [
                    (data['fileUrl'] ?? '').toString().isEmpty
                        ? Image.asset(
                            'assets/images/news.jpg',
                            width: double.infinity,
                            height: 320,
                            fit: BoxFit.cover,
                          )
                        : data['fileType'] == "video"
                        ? SizedBox(
                            height: 320,
                            width: double.infinity,
                            child: VideoPreview(videoUrl: data['fileUrl']),
                          )
                        : Image.network(
                            data['fileUrl'],
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

                    Positioned(
                      top: 16,
                      right: 16,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      /// TAGS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xff3F4C8F),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              data['source'] ?? 'الجزيرة',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xff3F4C8F),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "عاجل",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// TITLE
                      Text(
                        data['title'] ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: BuyerDetailsScreen._infoCard(
                              "الموقع",
                              data['region'] ?? '',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: BuyerDetailsScreen._infoCard(
                              "وقت التصوير",
                              data['createdAt'] != null
                                  ? (data['createdAt'] as Timestamp)
                                        .toDate()
                                        .toString()
                                        .substring(0, 10)
                                  : '',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: BuyerDetailsScreen._infoCard(
                              "المشاهدات",
                              BuyerDetailsScreen.views,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: BuyerDetailsScreen._infoCard(
                              "الجودة",
                              BuyerDetailsScreen.quality,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      /// OWNER
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(170, 197, 210, 230),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(radius: 25),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['userName']?.toString() ??
                                        'مراسل الخبر',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),

                                  const Text("غزة - موثق"),
                                ],
                              ),
                            ),

                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "+ تابع",
                                selectionColor: Color.fromARGB(
                                  255,
                                  255,
                                  255,
                                  255,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff3F4C8F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                      if (isSold)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              "تم بيع الحقوق الحصرية لهذا المحتوى",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),

                      /// PRICE
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(170, 197, 210, 230),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.black26),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "\$${data['price']?.toString() ?? '0'}",
                                  style: const TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                const Text("سعر الحقوق الحصرية"),
                              ],
                            ),

                            const SizedBox(height: 15),

                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: isLoading || isSold
                                        ? null
                                        : () async {
                                            final result = await showDialog<bool>(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  title: const Row(
                                                    children: [
                                                      Icon(
                                                        Icons.shopping_cart,
                                                        color: Colors.green,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text("تأكيد الشراء"),
                                                    ],
                                                  ),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const Text(
                                                        "سيتم خصم المبلغ من رصيدك وإضافة المحتوى إلى مشترياتك.",
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        "\$${data['price']}",
                                                        style: const TextStyle(
                                                          fontSize: 28,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                          context,
                                                          false,
                                                        );
                                                      },
                                                      child: const Text(
                                                        "إلغاء",
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      style:
                                                          ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.green,
                                                          ),
                                                      onPressed: () {
                                                        Navigator.pop(
                                                          context,
                                                          true,
                                                        );
                                                      },
                                                      child: const Text(
                                                        "تأكيد الشراء",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );

                                            if (result == true) {
                                              buyContent();
                                            }
                                          },
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: const Color(0xff3F4C8F),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: isLoading
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Text(
                                            isSold ? "تم البيع" : "شراء الآن",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite_border),
                                ),

                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.share_outlined),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

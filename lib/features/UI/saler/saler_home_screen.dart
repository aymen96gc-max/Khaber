import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khabar/core/routing/routes.dart';

class SalerHomeScreen extends StatefulWidget {
  const SalerHomeScreen({super.key});

  @override
  State<SalerHomeScreen> createState() => _SalerHomeScreenState();

  // ACTION ITEM
  static Widget actionItem(
    SvgPicture icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: icon,
          ),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  static Widget statItem(String value, String label, String sub) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(sub, style: const TextStyle(color: Colors.green, fontSize: 12)),
      ],
    );
  }

  // SALES ITEM

  static Widget saleItem(String price, String title, String imageUrl) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl,
          width: 55,
          height: 55,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              "assets/images/news.jpg",
              width: 55,
              height: 55,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
      title: Text(title, textAlign: TextAlign.right),
      trailing: Text(price),
    );
  }
}

class _SalerHomeScreenState extends State<SalerHomeScreen> {
  String? name;
  String? imageUrl;

  Stream<DocumentSnapshot<Map<String, dynamic>>> get userStream {
    return FirebaseFirestore.instance
        .collection("salers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Stream<QuerySnapshot> get userNewsStream {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    return FirebaseFirestore.instance
        .collection('orders')
        .where('sallerId', isEqualTo: user.uid)
        .snapshots();
  }

  Future<void> fetchUser() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection("salers")
          .doc(user.uid)
          .get();

      if (!mounted) return;

      if (doc.exists) {
        setState(() {
          name = "${doc.data()?['firstName'] ?? ''} ";
          imageUrl = doc.data()?['fileUrl']?.toString() ?? '';
        });
      }
    } catch (e) {
      debugPrint('Error fetching user: $e');
    }
  }

  Widget buildSalesList() {
    return StreamBuilder<QuerySnapshot>(
      stream: userNewsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('خطأ في التحميل: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text("لا توجد أخبار مرفوعة");
        }

        final docs = snapshot.data!.docs.toList();
        docs.sort((a, b) {
          final aData = a.data() as Map<String, dynamic>;
          final bData = b.data() as Map<String, dynamic>;
          final aTime = aData['createdAt'] as Timestamp?;
          final bTime = bData['createdAt'] as Timestamp?;
          return (bTime?.millisecondsSinceEpoch ?? 0).compareTo(
            aTime?.millisecondsSinceEpoch ?? 0,
          );
        });

        return Column(
          children: docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;

            return SalerHomeScreen.saleItem(
              "\$${data['price'] ?? 0}",
              data['title'] ?? '',
              data['fileUrl'] ?? '',
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.notifications,
                    color: Colors.amber,
                    size: 28,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "مرحباً , ${name ?? ""}",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),

                  /// Avatar
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                        ? NetworkImage(imageUrl!)
                        : null,
                    child: imageUrl == null || imageUrl!.isEmpty
                        ? const Icon(Icons.person)
                        : null,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// BALANCE CARD
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff3F4C8F), Color(0xff5663C1)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Stack(
                  children: [
                    /// blurred circle
                    Positioned(
                      left: 0,
                      top: 10,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "رصيدك الحالي",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),

                        const SizedBox(height: 8),

                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          stream: userStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Text(
                                "\$0",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }

                            final data = snapshot.data!.data();

                            final balance = (data?['balance'] ?? 0).toDouble();

                            return Text(
                              "\$${balance.toStringAsFixed(2)}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 14),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Withdraw
                            OutlinedButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.salerWalletScreen,
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              icon: const Icon(
                                Icons.credit_card,
                                color: Colors.orange,
                              ),
                              label: const Text(
                                "سحب الرصيد",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "إجمالي  \$11,420",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "معلق  \$850",
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// QUICK ACTIONS
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "الإجراءات السريعة",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SalerHomeScreen.actionItem(
                    SvgPicture.asset("assets/svgs/upload.svg"),
                    "رفع محتوى",
                    Colors.blue,
                    () {
                      Navigator.pushNamed(context, Routes.salerUploadScreen);
                    },
                  ),
                  SalerHomeScreen.actionItem(
                    SvgPicture.asset("assets/svgs/content.svg"),
                    "محتواي",
                    Colors.cyan,
                    () {
                      Navigator.pushNamed(context, Routes.salerContentScreen);
                    },
                  ),
                  SalerHomeScreen.actionItem(
                    SvgPicture.asset("assets/svgs/sales.svg"),
                    "محفظتي",
                    Colors.pink,
                    () {
                      Navigator.pushNamed(context, Routes.salerWalletScreen);
                    },
                  ),
                  SalerHomeScreen.actionItem(
                    SvgPicture.asset("assets/svgs/messages.svg"),
                    "الرسائل",
                    Colors.orange,
                    () {
                      Navigator.pushNamed(context, Routes.salermessagesScreen);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 22),

              /// STATS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SalerHomeScreen.statItem("4.9⭐", "تقييمك", "ممتاز"),
                  SalerHomeScreen.statItem("8", "صفقات ناجحة", "+3 هذا الشهر"),
                  SalerHomeScreen.statItem(
                    "14",
                    "مواد منشورة",
                    "+2 هذا الأسبوع",
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // CHART
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "الأرباح الشهرية",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 150,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    7,
                    (i) => Container(
                      width: 28,
                      height: [140, 120, 100, 80, 60, 90, 110][i].toDouble(),
                      decoration: BoxDecoration(
                        color: i == 0
                            ? Color(0xff3F4C8F)
                            : Color(0xff5663C1).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// URGENT CARD
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff0D0D2B), Color(0xff2A2A72)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.flash_on, color: Colors.orange, size: 40),
                    const SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.salerContentScreen,
                            );
                          },
                          child: const Text(
                            "طلبات عاجلة بانتظارك",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),

                        SizedBox(height: 4),
                        Text(
                          "2 طلبات الآن",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// SALES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "عرض الكل",
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  Text(
                    "آخر المبيعات",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              buildSalesList(),
            ],
          ),
        ),
      ),
    );
  }
}

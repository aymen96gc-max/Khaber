import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuyerDetailsScreen extends StatelessWidget {
  const BuyerDetailsScreen({super.key});

  static const String views = "15,000 مشاهدة";
  static const String quality = "4K - 2:40";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null) {
      return const Scaffold(body: Center(child: Text('لا توجد بيانات')));
    }

    final data = args as Map<String, dynamic>;

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
                    Image.network(
                      data['image'] ?? '',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          height: 320,
                          color: Color.fromARGB(255, 197, 210, 230),
                          child: const Icon(Icons.image, size: 80),
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

                    const Positioned.fill(
                      child: Center(
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.play_arrow,
                            size: 40,
                            color: Colors.blueAccent,
                          ),
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
                            child: _infoCard("الموقع", data['region'] ?? ''),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _infoCard(
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
                          Expanded(child: _infoCard("المشاهدات", views)),
                          const SizedBox(width: 10),
                          Expanded(child: _infoCard("الجودة", quality)),
                        ],
                      ),

                      const SizedBox(height: 15),

                      /// OWNER
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 197, 210, 230),
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
                              child: const Text("+ تابع"),
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

                      /// PRICE
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 197, 210, 230),
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
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Color(0xff3F4C8F),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text("شراء الآن"),
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

  static Widget _infoCard(String title, dynamic value) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 197, 210, 230),
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

import 'package:flutter/material.dart';

class SalerUploadScreen extends StatelessWidget {
  const SalerUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /// TITLE
                Row(
                  children: [
                    const Icon(Icons.arrow_forward_ios, size: 18),
                    const SizedBox(width: 8),
                    const Text(
                      "رفع محتوى جديد",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// UPLOAD BOX
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Image.network(
                        "https://cdn-icons-png.flaticon.com/512/3277/3277296.png",
                        height: 70,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "اسحب الملف هنا أو اضغط الملف",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "فيديو او صورة بدقة عالية",
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 14),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          tag("🎥 فيديو"),
                          const SizedBox(width: 10),
                          tag("🖼 صور"),
                          const SizedBox(width: 10),
                          tag("🎤 صوت"),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                field("عنوان الخبر"),
                field("وصف مختصر", maxLines: 3),

                const SizedBox(height: 12),

                /// LOCATION FIELDS
                Row(
                  children: [
                    Expanded(child: field("الموقع")),
                    const SizedBox(width: 10),
                    Expanded(child: field("المدينة")),
                  ],
                ),

                const SizedBox(height: 10),

                /// MAP
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://maps.gstatic.com/tactile/basepage/pegman_sherlock.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: Colors.red, size: 40),
                        Text("اضغط لتحديد الموقع على الخريطة"),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                field("وقت التصوير"),

                const SizedBox(height: 16),

                /// CATEGORY
                const Text(
                  "التصنيف",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),

                const SizedBox(height: 10),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    chip("🚒 حوادث"),
                    chip("🏛 سياسة"),
                    chip("⚔️ حرب"),
                    chip("⚽ رياضة"),
                    chip("💰 اقتصاد"),
                    chip("🌍 طبيعة"),
                  ],
                ),

                const SizedBox(height: 20),

                /// RIGHTS
                const Text(
                  "نوع الحقوق",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(child: rightsCard(false)),
                    const SizedBox(width: 10),
                    Expanded(child: rightsCard(true)),
                  ],
                ),

                const SizedBox(height: 20),

                /// PRICE
                const Text(
                  "السعر (USD)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),

                const SizedBox(height: 8),

                TextField(
                  decoration: InputDecoration(
                    hintText: "\$ 500",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// PUBLISH BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "نشر للبيع التطبيق",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// TAG BUTTON
  static Widget tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  /// TEXT FIELD
  static Widget field(String hint, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  /// CATEGORY CHIP
  static Widget chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xffF56C6C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  /// RIGHTS CARD
  static Widget rightsCard(bool selected) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: selected ? Colors.red : Colors.grey.shade300,
          width: selected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            selected ? Icons.diamond : Icons.lock,
            color: selected ? Colors.blue : Colors.blueGrey,
            size: 40,
          ),
          const SizedBox(height: 10),
          Text(
            selected ? "حصري" : "غير حصري",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            selected ? "بيع مرة واحدة فقط" : "بيع لأكثر من جهة",
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Text(
            selected ? "سعر أعلى" : "سعر أقل",
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class SalerUploadScreen extends StatefulWidget {
  const SalerUploadScreen({super.key});

  @override
  State<SalerUploadScreen> createState() => _SalerUploadScreenState();

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
  static Widget field(
    String hint, {
    int maxLines = 3,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        maxLines: maxLines,
        controller: controller,
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

class _SalerUploadScreenState extends State<SalerUploadScreen> {
  TextEditingController newaddressnameController = TextEditingController();
  TextEditingController newaddressController = TextEditingController();
  TextEditingController newdescriptionController = TextEditingController();
  TextEditingController newtimeController = TextEditingController();
  TextEditingController newpriceController = TextEditingController();
  String? fileType;
  String? selectedRegion;

  @override
  void initState() {
    super.initState();
  }

  Future<String?> uploadFile(File file) async {
    try {
      String fileName =
          DateTime.now().millisecondsSinceEpoch.toString() +
          "_" +
          path.basename(file.path);

      Reference storageRef = FirebaseStorage.instance.ref().child(
        "uploads/$fileName",
      );

      UploadTask uploadTask = storageRef.putFile(file);

      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  Future<void> newUploade() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (pickedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("⚠️ الرجاء اختيار صورة أو فيديو")),
        );
        return;
      }
      if (user == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("⚠️ يجب تسجيل الدخول")));
        return;
      }

      String fileUrl = await uploadFile(pickedFile!) ?? "";

      /// حفظ البيانات في Firestore
      await FirebaseFirestore.instance.collection("newsupload").add({
        "userId": user.uid,
        "title": newaddressnameController.text.trim(),
        "description": newdescriptionController.text.trim(),
        "region": selectedRegion ?? "",
        "address": newaddressController.text.trim(),
        "date": newtimeController.text.trim(),
        "price": double.tryParse(newpriceController.text.trim()) ?? 0.0,
        "image": fileUrl,
        "fileType": fileType,
        "type": fileType == "video" ? fileUrl : fileUrl,
        "createdAt": FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("✅ تم الرفع بنجاح")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ خطأ: $e")));
    }
  }

  File? pickedFile;
  final ImagePicker picker = ImagePicker();

  Future<void> pickMedia() async {
    final XFile? file = await showModalBottomSheet<XFile?>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('اختيار صورة'),
                onTap: () async {
                  final result = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  Navigator.pop(context, result);
                },
              ),
              ListTile(
                leading: const Icon(Icons.video_file),
                title: const Text('اختيار فيديو'),
                onTap: () async {
                  final result = await picker.pickVideo(
                    source: ImageSource.gallery,
                  );
                  Navigator.pop(context, result);
                },
              ),
            ],
          ),
        );
      },
    );

    if (file != null) {
      setState(() {
        pickedFile = File(file.path);

        String path = file.path.toLowerCase();

        if (path.endsWith(".mp4") ||
            path.endsWith(".mov") ||
            path.endsWith(".avi")) {
          fileType = "video";
        } else {
          fileType = "image";
        }
      });
    }
  }

  @override
  void dispose() {
    newaddressController.dispose();
    newaddressnameController.dispose();
    newdescriptionController.dispose();
    newtimeController.dispose();
    newpriceController.dispose();
    super.dispose();
  }

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

                /// Upload Box
                GestureDetector(
                  onTap: pickMedia,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        if (pickedFile != null)
                          fileType == "video"
                              ? const Icon(
                                  Icons.video_file,
                                  size: 70,
                                  color: Colors.red,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    pickedFile!,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                        else
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
                            SalerUploadScreen.tag("🎥 فيديو"),
                            const SizedBox(width: 10),
                            SalerUploadScreen.tag("📷 صور"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SalerUploadScreen.field(
                  "عنوان الخبر",
                  controller: newaddressnameController,
                ),
                SalerUploadScreen.field(
                  "وصف مختصر",
                  maxLines: 3,
                  controller: newdescriptionController,
                ),

                const SizedBox(height: 12),

                /// LOCATION FIELDS
                Row(
                  children: [
                    Expanded(
                      child: SalerUploadScreen.field(
                        "الموقع",
                        controller: newaddressController,
                      ),
                    ),
                    const SizedBox(width: 10),

                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedRegion,
                        decoration: InputDecoration(
                          hintText: "اختر المنطقة",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: "غزة", child: Text("غزة")),
                          DropdownMenuItem(
                            value: "سوريا",
                            child: Text("سوريا"),
                          ),
                          DropdownMenuItem(value: "مصر", child: Text("مصر")),
                          DropdownMenuItem(
                            value: "الأردن",
                            child: Text("الأردن"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedRegion = value;
                          });
                        },
                      ),
                    ),
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

                SalerUploadScreen.field(
                  "وقت التصوير",
                  controller: newtimeController,
                ),

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
                    SalerUploadScreen.chip("🚒 حوادث"),
                    SalerUploadScreen.chip("🏛 سياسة"),
                    SalerUploadScreen.chip("⚔️ حرب"),
                    SalerUploadScreen.chip("⚽ رياضة"),
                    SalerUploadScreen.chip("💰 اقتصاد"),
                    SalerUploadScreen.chip("🌍 طبيعة"),
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
                    Expanded(child: SalerUploadScreen.rightsCard(false)),
                    const SizedBox(width: 10),
                    Expanded(child: SalerUploadScreen.rightsCard(true)),
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
                  controller: newpriceController,
                  keyboardType: TextInputType.number,
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
                    onPressed: newUploade,
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
}

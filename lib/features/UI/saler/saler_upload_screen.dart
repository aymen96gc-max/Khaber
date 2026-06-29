import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
}

class _SalerUploadScreenState extends State<SalerUploadScreen> {
  TextEditingController newaddressnameController = TextEditingController();
  TextEditingController newaddressController = TextEditingController();
  TextEditingController newdescriptionController = TextEditingController();
  TextEditingController newtimeController = TextEditingController();
  TextEditingController newpriceController = TextEditingController();
  String? fileType;
  String? selectedRegion;
  LatLng? selectedLocation;
  DateTime? selectedDate;

  bool isUploading = false;

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;

        newtimeController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

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

      final sallerDoc = await FirebaseFirestore.instance
          .collection("salers")
          .doc(user.uid)
          .get();

      final sallerName =
          "${sallerDoc.data()?["firstName"] ?? ""} "
          "${sallerDoc.data()?["lastName"] ?? ""}";

      String fileUrl = await uploadFile(pickedFile!) ?? "";

      /// حفظ البيانات في Firestore
      final doc = FirebaseFirestore.instance.collection("newsupload").doc();
      await doc.set({
        "docId": doc.id,
        "sallerId": user.uid,
        "buyerId": null,
        "userName": sallerName,
        "title": newaddressnameController.text.trim(),
        "description": newdescriptionController.text.trim(),
        "region": selectedRegion ?? "",
        "address": newaddressController.text.trim(),
        "date": selectedDate == null ? null : Timestamp.fromDate(selectedDate!),
        "price": double.tryParse(newpriceController.text.trim()) ?? 0,
        "latitude": selectedLocation?.latitude,
        "longitude": selectedLocation?.longitude,
        "fileUrl": fileUrl,
        "fileType": fileType,
        "isSold": false,
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
                    const Icon(Icons.arrow_back, size: 18),
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
                        "العنوان",
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

                Container(
                  height: 220,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(31.5017, 34.4668),
                      initialZoom: 12,
                      onTap: (tapPosition, point) {
                        setState(() {
                          selectedLocation = point;
                        });
                      },
                    ),

                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
                        subdomains: const ['a', 'b', 'c', 'd'],
                        userAgentPackageName: 'com.khabar.app',
                      ),

                      if (selectedLocation != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: selectedLocation!,
                              width: 40,
                              height: 40,
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: newtimeController,
                  readOnly: true,
                  onTap: pickDate,
                  decoration: InputDecoration(
                    hintText: "اختر تاريخ التصوير",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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

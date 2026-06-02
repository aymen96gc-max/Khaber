import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khabar/core/helper/extension.dart';
import 'package:khabar/core/routing/routes.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  // ✅ جعل الشاشة StatefulWidget لتمكين اختيار نوع المستخدم
  _UserTypeScreenState createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              /// العنوان
              Center(
                child: Text(
                  "كيف سنستخدم التطبيق؟",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              SizedBox(height: 6),

              Center(
                child: Text(
                  "اختر نوع حسابك - يمكنك تغييره لاحقاً",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ),

              SizedBox(height: 25),

              /// بطاقة البائع
              _buildCard(
                index: 0,
                title: "بائع محتوى",
                subtitle: "صور وفيديوهات للقنوات العالمية",
                tags: ["حصري", "مراسل", "محتوى مميز"],
                color: Colors.red,
                bgColor: Color(0xFFFFF1F1),
                iconBg: Color(0xFFFFF1F1),
                svgimage: "assets/svgs/camera.svg",
              ),

              SizedBox(height: 20),

              /// بطاقة المشتري
              _buildCard(
                index: 1,
                title: "مشتري محتوى",
                subtitle: "قنوات، وكالات، وصور حصرية وفورية",
                tags: ["وكالة", "قناة إعلامية"],
                color: Colors.blue,
                bgColor: Color(0xFFF2F8FF),
                iconBg: Color(0xFFF2F8FF),
                svgimage: "assets/svgs/video_camera.svg",
              ),

              Spacer(),

              /// الزر
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: selectedIndex == -1
                      ? null
                      : () {
                          context.pushNamed(Routes.loginScreen);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1E4F8A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    "اختر نوع الحساب أولاً",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required int index,
    required String title,
    required String subtitle,
    required List<String> tags,
    required Color color,
    required Color bgColor,
    required Color iconBg,
    required String svgimage,
  }) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            /// Radio
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),

            SizedBox(width: 15),

            /// النصوص
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 6),

                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),

                  SizedBox(height: 10),

                  Wrap(
                    spacing: 6,
                    children: tags
                        .map(
                          (tag) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(fontSize: 11, color: color),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),

            SizedBox(width: 10),

            /// الأيقونة
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: SvgPicture.asset(svgimage, width: 20, height: 20),
            ),
          ],
        ),
      ),
    );
  }
}

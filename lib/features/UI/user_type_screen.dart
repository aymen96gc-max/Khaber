import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khabar/features/UI/login_screen.dart';

class UserTypeScreen extends StatefulWidget {
  @override
  _UserTypeScreenState createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 20),

                /// Title
                Text(
                  "كيف ستستخدم التطبيق؟",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                Text(
                  "اختر نوع حسابك - يمكنك تغييره لاحقاً",
                  style: TextStyle(color: Colors.grey[700]),
                ),

                const SizedBox(height: 30),

                /// Seller
                _buildOptionCard(
                  index: 0,
                  title: "بائع محتوى",
                  subtitle: "صور و فيديوهات للبيع للقنوات الإعلامية",
                  color: Colors.red,
                  svgPath: "assets/svgs/camera.svg",
                  tags: ["مراسل", "مصور", "صحفي ميداني"],
                ),

                const SizedBox(height: 20),

                /// Buyer
                _buildOptionCard(
                  index: 1,
                  title: "مشتري محتوى",
                  subtitle: "اشتر فيديوهات وصور حصرية وفورية",
                  color: Colors.blue,
                  svgPath: "assets/svgs/video_camera.svg",
                  tags: ["قناة", "وكالة", "منظمة إعلامية"],
                ),

                const Spacer(),

                /// Button
                ElevatedButton(
                  onPressed: selectedIndex == -1
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    minimumSize: Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 8),
                      Text(
                        "اختر نوع الحساب اولاً",
                        style: TextStyle(fontSize: 16),
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

  Widget _buildOptionCard({
    required int index,
    required String title,
    required String subtitle,
    required Color color,
    required String svgPath,
    required List<String> tags,
  }) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => selectedIndex = index);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : color.withOpacity(0.4),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            /// Radio
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: color,
            ),

            const SizedBox(width: 12),

            /// Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(subtitle, style: TextStyle(color: Colors.grey[700])),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 6,
                    children: tags
                        .map(
                          (e) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(e, style: TextStyle(color: color)),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            /// SVG Icon
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: SvgPicture.asset(svgPath, width: 40, height: 40),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dummy next screen
class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الصفحة التالية")),
      body: Center(child: Text("تم الانتقال بنجاح")),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:khabar/core/helper/home_switcher.dart';
import 'package:khabar/core/routing/routes.dart';
import 'package:khabar/features/UI/content_screen.dart';
import 'package:khabar/features/UI/massege.dart';
import 'package:khabar/features/UI/notification.dart';
import 'package:khabar/features/UI/home_screen.dart';
import 'package:khabar/features/UI/login_screen.dart';
import 'package:khabar/features/UI/orders_screen.dart';
import 'package:khabar/features/UI/profile.dart';
import 'package:khabar/features/UI/sales_screen.dart';
import 'package:khabar/features/UI/signup_screen.dart';
import 'package:khabar/features/UI/user_type_screen.dart';
import 'package:khabar/features/UI/upload_screen.dart';
import 'package:khabar/features/onboarding/onboarding_screen.dart';
import 'package:khabar/features/onboarding/onboarding_screen_2nd.dart';
import 'package:khabar/features/onboarding/onboarding_screen_3ed.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    /// ✅ يمكنك استخدام settings.arguments لتمرير البيانات بين الصفحات إذا لزم الأمر
    switch (settings.name) {
      /// لانشاء route بين الصفحات
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(
            onClickSignUp: () {
              // يمكنك تنفيذ أي منطق إضافي هنا إذا لزم الأمر
            },
          ),
        );
      case Routes.homeSwitcher:
        return MaterialPageRoute(builder: (_) => HomeSwitcher());
      case Routes.userTypeScreen:
        return MaterialPageRoute(builder: (_) => UserTypeScreen());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case Routes.onboarding2:
        return MaterialPageRoute(builder: (_) => Onboarding_screen_2nd());
      case Routes.onboarding3:
        return MaterialPageRoute(builder: (_) => Onboarding_screen_3ed());
      case Routes.notifications:
        return MaterialPageRoute(builder: (_) => NotificationsScreen());
      case Routes.orderScreen:
        return MaterialPageRoute(builder: (_) => OrdersScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case Routes.uploadScreen:
        return MaterialPageRoute(builder: (_) => UploadScreen());
      case Routes.massegeScreen:
        return MaterialPageRoute(builder: (_) => MassegeScreen());
      case Routes.salesScreen:
        return MaterialPageRoute(builder: (_) => SalesScreen());
      case Routes.contentScreen:
        return MaterialPageRoute(builder: (_) => ContentScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

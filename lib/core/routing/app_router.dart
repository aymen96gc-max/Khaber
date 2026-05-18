import 'package:flutter/material.dart';
import 'package:khabar/core/routing/routes.dart';
import 'package:khabar/features/UI/dashboard_screen.dart';
import 'package:khabar/features/UI/login_screen.dart';
import 'package:khabar/features/UI/signup_screen.dart';
import 'package:khabar/features/UI/user_type_screen.dart';
import 'package:khabar/features/onboarding/onboarding_screen.dart';
import 'package:khabar/features/onboarding/onboarding_screen_2nd.dart';
import 'package:khabar/features/onboarding/onboarding_screen_3ed.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    /// ✅ يمكنك استخدام settings.arguments لتمرير البيانات بين الصفحات إذا لزم الأمر
    final arguments = settings.arguments;
    switch (settings.name) {
      /// لانشاء route بين الصفحات
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.userTypeScreen:
        return MaterialPageRoute(builder: (_) => UserTypeScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.onboarding2:
        return MaterialPageRoute(builder: (_) => const Onboarding_screen_2nd());
      case Routes.onboarding3:
        return MaterialPageRoute(builder: (_) => const Onboarding_screen_3ed());
      case Routes.dashboardScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

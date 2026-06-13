import 'package:flutter/material.dart';
import 'package:khabar/core/helper/saler_home_switcher.dart';
import 'package:khabar/core/helper/buyer_home_switcher.dart';
import 'package:khabar/core/routing/routes.dart';
import 'package:khabar/features/UI/buyer/buyer_login_screen.dart';
import 'package:khabar/features/UI/buyer/buyer_signup_screen.dart';
import 'package:khabar/features/UI/saler/saler_login_screen.dart';
import 'package:khabar/features/UI/saler/saler_signup_screen.dart';
import 'package:khabar/features/UI/user_type_screen.dart';
import 'package:khabar/features/onboarding/onboarding_screen.dart';
import 'package:khabar/features/onboarding/onboarding_screen_2nd.dart';
import 'package:khabar/features/onboarding/onboarding_screen_3ed.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.buyerhomeSwitcher:
        return MaterialPageRoute(builder: (_) => BuyerHomeSwitcher());
      case Routes.salerhomeSwitcher:
        return MaterialPageRoute(builder: (_) => SalerHomeSwitcher());
      case Routes.userTypeScreen:
        return MaterialPageRoute(builder: (_) => UserTypeScreen());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case Routes.onboarding2:
        return MaterialPageRoute(builder: (_) => Onboarding_screen_2nd());
      case Routes.onboarding3:
        return MaterialPageRoute(builder: (_) => Onboarding_screen_3ed());
      case Routes.salerLoginScreen:
        return MaterialPageRoute(
          builder: (context) => SalerLoginScreen(
            onClickSignUp: () =>
                Navigator.of(context).pushNamed(Routes.salerSignupScreen),
          ),
        );

      case Routes.buyerLoginScreen:
        return MaterialPageRoute(
          builder: (context) => BuyerLoginScreen(
            onClickSignUp: () =>
                Navigator.of(context).pushNamed(Routes.buyerSignupScreen),
          ),
        );
      case Routes.salerSignupScreen:
        return MaterialPageRoute(
          builder: (context) => SalerSignupScreen(
            onClickSignIn: () => Navigator.of(context).pop(),
          ),
        );
      case Routes.buyerSignupScreen:
        return MaterialPageRoute(
          builder: (context) => BuyerSignupScreen(
            onClickSignIn: () => Navigator.of(context).pop(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

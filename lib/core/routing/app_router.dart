import 'package:flutter/material.dart';
import 'package:khabar/core/helper/saler_home_switcher.dart';
import 'package:khabar/core/helper/buyer_home_switcher.dart';
import 'package:khabar/core/routing/routes.dart';
import 'package:khabar/features/UI/buyer/buyer_detailes_screen.dart';
import 'package:khabar/features/UI/buyer/buyer_login_screen.dart';
import 'package:khabar/features/UI/buyer/buyer_purchases_screen.dart';
import 'package:khabar/features/UI/buyer/buyer_signup_screen.dart';
import 'package:khabar/features/UI/saler/saler_content.dart';
import 'package:khabar/features/UI/saler/saler_home_screen.dart';
import 'package:khabar/features/UI/saler/saler_login_screen.dart';
import 'package:khabar/features/UI/saler/saler_message.dart';
import 'package:khabar/features/UI/saler/saler_notificitoin.dart';
import 'package:khabar/features/UI/saler/saler_profile_screen.dart';
import 'package:khabar/features/UI/saler/saler_signup_screen.dart';
import 'package:khabar/features/UI/saler/saler_upload_screen.dart';
import 'package:khabar/features/UI/saler/saler_wallet.dart';
import 'package:khabar/features/UI/user_type_screen.dart';
import 'package:khabar/features/onboarding/onboarding_screen.dart';
import 'package:khabar/features/onboarding/onboarding_screen_2nd.dart';
import 'package:khabar/features/onboarding/onboarding_screen_3ed.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.buyerhomeSwitcher:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BuyerHomeSwitcher(),
        );
      case Routes.salerhomeSwitcher:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SalerHomeSwitcher(),
        );
      case Routes.userTypeScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => UserTypeScreen(),
        );
      case Routes.onboarding:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => OnboardingScreen(),
        );
      case Routes.onboarding2:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => OnboardingScreen2nd(),
        );
      case Routes.onboarding3:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => OnboardingScreen3ed(),
        );
      case Routes.salerLoginScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => SalerLoginScreen(
            onClickSignUpSaler: () =>
                Navigator.of(context).pushNamed(Routes.salerSignupScreen),
          ),
        );

      case Routes.buyerLoginScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BuyerLoginScreen(
            onClickSignUpBuyer: () =>
                Navigator.of(context).pushNamed(Routes.buyerSignupScreen),
          ),
        );
      case Routes.salerSignupScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => SalerSignupScreen(
            onClickSignInSaler: () => Navigator.of(context).pop(),
          ),
        );
      case Routes.buyerSignupScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BuyerSignupScreen(
            onClickSignInBuyer: () => Navigator.of(context).pop(),
          ),
        );
      case Routes.salerUploadScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SalerUploadScreen(),
        );
      case Routes.salerNotificationScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SalerNotificationsScreen(),
        );
      case Routes.salerContentScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SalerContentScreen(),
        );
      case Routes.salerprofileScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SalerProfileScreen(),
        );
      case Routes.salerhomeScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SalerHomeScreen(),
        );
      case Routes.salermessagesScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SalerMessageScreen(),
        );
      case Routes.salerWalletScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SalerWalletScreen(),
        );

      case Routes.buyerdetailsScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const BuyerDetailsScreen(),
        );

      case Routes.buyerPurchasesScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BuyerPurchasesScreen(),
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

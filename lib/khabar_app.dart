import 'package:flutter/material.dart';
import 'package:khabar/core/routing/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khabar/core/routing/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KhabarApp extends StatefulWidget {
  final AppRouter appRouter;

  const KhabarApp({super.key, required this.appRouter});

  @override
  State<KhabarApp> createState() => _KhabarAppState();
}

class _KhabarAppState extends State<KhabarApp> {
  String _initialRoute = Routes.onboarding;

  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    setState(() {
      _initialRoute = hasSeenOnboarding
          ? Routes.userTypeScreen
          : Routes.onboarding;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Set the design size to match your Figma design dimensions
      designSize: const Size(402, 874),
      minTextAdapt: true,
      // Enable split-screen mode support
      builder: (context, child) {
        return MaterialApp(
          title: 'Khabar',
          theme: ThemeData(primarySwatch: Colors.blue),
          locale: const Locale('ar', 'SA'), // Set Arabic locale
          onGenerateRoute: widget.appRouter.generateRoute,
          debugShowCheckedModeBanner: false,
          initialRoute: _initialRoute,
        );
      },
    );
  }
}

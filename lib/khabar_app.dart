import 'package:flutter/material.dart';
import 'package:khabar/core/routing/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khabar/core/routing/routes.dart';

class KhabarApp extends StatelessWidget {
  final AppRouter appRouter;

  const KhabarApp({super.key, required this.appRouter});

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
          onGenerateRoute: appRouter.generateRoute,
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.onboarding,
        );
      },
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khabar/core/routing/app_router.dart';
import 'package:khabar/firebase_options.dart';
import 'package:khabar/khabar_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(KhabarApp(appRouter: AppRouter()));
}

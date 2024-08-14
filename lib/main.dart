import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/introduction_pages/onboarding_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
    );
  }
}

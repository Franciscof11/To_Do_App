import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:to_do_app/modules/auth/data/auth_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final authFirebaseRepository = AuthRepository();
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/splash.json'),
      pageTransitionType: PageTransitionType.fade,
      splashTransition: SplashTransition.fadeTransition,
      duration: 3900,
      backgroundColor: const Color.fromRGBO(228, 240, 246, 1),
      splashIconSize: 80000,
      nextScreen: authFirebaseRepository.authChanges(context),
    );
  }
}

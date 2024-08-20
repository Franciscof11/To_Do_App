import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:to_do_app/modules/auth/data/auth_repository.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/introduction_pages/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  final bool isFirstTime;
  const SplashScreen({super.key, required this.isFirstTime});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

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
      nextScreen: widget.isFirstTime ? const OnBoardingScreen() : authFirebaseRepository.authChanges(context),
    );
  }
}

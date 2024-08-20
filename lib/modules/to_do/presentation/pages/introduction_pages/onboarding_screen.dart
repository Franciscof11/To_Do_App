import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_app/modules/auth/presentation/pages/sign_in_page.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/introduction_pages/intro_page_1.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/introduction_pages/intro_page_2.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/introduction_pages/intro_page_3.dart';
import 'package:to_do_app/utils/app_colors.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Stack(
          children: [
            //PageView
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  if (index == 2) {
                    onLastPage = true;
                  }
                });
              },
              children: const [
                IntroPage1(),
                IntroPage2(),
                IntroPage3(),
              ],
            ),

            //
            //DotIndicator
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        _controller.jumpToPage(2);
                      },
                      child: Text(
                        'Pular',
                        style: GoogleFonts.raleway(
                          color: Colors.green.shade400,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: WormEffect(
                        dotColor: Colors.grey,
                        activeDotColor: AppColors.mainGreen!,
                      ),
                    ),
                    onLastPage
                        ? TextButton(
                            onPressed: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();

                              await prefs.setBool('isFirstTime', false);

                              if (context.mounted) {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    child: const SignInPage(),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Concluir',
                              style: GoogleFonts.raleway(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : TextButton(
                            onPressed: () {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            },
                            child: Text(
                              'Próximo',
                              style: GoogleFonts.raleway(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

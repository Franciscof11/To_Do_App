import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/home_page/home_page.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/introduction_pages/intro_page_1.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/introduction_pages/intro_page_2.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/introduction_pages/intro_page_3.dart';

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
                        activeDotColor: Colors.green.shade300,
                      ),
                    ),
                    onLastPage
                        ? TextButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const HomePage()),
                              );
                              /*               //
                          // Check if is the first launch
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('firstLaunch', false); */
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

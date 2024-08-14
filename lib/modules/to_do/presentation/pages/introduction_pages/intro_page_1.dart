import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            SvgPicture.asset(
              'assets/intro_1.svg',
              height: 350,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text.rich(
                TextSpan(
                  text: 'Bem Vindo(a)!',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Tarefas sob controle,\n',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: 'mente em paz. ',
                      style: GoogleFonts.raleway(
                        color: Colors.green.shade400,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const TextSpan(
                      text: 'Organize, ',
                    ),
                    const TextSpan(
                      text: 'priorize, ',
                    ),
                    TextSpan(
                      text: 'realize.',
                      style: GoogleFonts.raleway(
                        color: Colors.green.shade400,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

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
              'assets/intro_3.svg',
              height: 350,
            ),
            const SizedBox(height: 40),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Gerencie suas ',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: 'atividades!',
                      style: GoogleFonts.raleway(
                        color: Colors.green.shade400,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'To Do App: ',
                      style: GoogleFonts.raleway(
                        color: Colors.green.shade400,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'sua rotina no controle.',
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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

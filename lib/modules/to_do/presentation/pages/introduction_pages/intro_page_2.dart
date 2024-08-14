import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

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
              'assets/intro_2.svg',
              height: 350,
            ),
            const SizedBox(height: 40),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Com o ',
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: 'To Do App, ',
                      style: GoogleFonts.raleway(
                        color: Colors.green.shade400,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const TextSpan(
                      text: 'transforme tarefas em ',
                    ),
                    TextSpan(
                      text: 'conquistas. ',
                      style: GoogleFonts.raleway(
                        color: Colors.green.shade400,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const TextSpan(
                      text: 'Tudo o que você precisa, ',
                    ),
                    TextSpan(
                      text: 'em um só lugar.',
                      style: GoogleFonts.raleway(
                        color: Colors.green.shade400,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
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

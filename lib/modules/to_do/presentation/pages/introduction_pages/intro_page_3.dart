import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final deviceH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: deviceH <= 750 ? 20 : 80,
            ),
            SvgPicture.asset(
              'assets/intro_3.svg',
              height: deviceH <= 750 ? 300 : 350,
            ),
            SizedBox(
              height: deviceH <= 750 ? 10 : 30,
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Escolha o seu ',
                  style: GoogleFonts.raleway(
                    color: Colors.grey[800],
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: 'tema:',
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
            SizedBox(height: deviceH <= 750 ? 28 : 35),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        'Dark Mode',
                        style: GoogleFonts.raleway(
                          color: isSelected ? Colors.grey[600] : Colors.green.shade400,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 35,
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        'Light Mode',
                        style: GoogleFonts.raleway(
                          color: isSelected == false ? Colors.grey[600] : Colors.green.shade400,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

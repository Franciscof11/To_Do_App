import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/modules/auth/data/auth_repository.dart';
import 'package:to_do_app/utils/app_colors.dart';

import '../../../../utils/remove_glow_effect.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(90),
      )),
      backgroundColor: Colors.grey.shade900,
      child: RemoveGlowEffect(
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: 'ToDo',
                style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: 'App',
                    style: GoogleFonts.raleway(
                      color: AppColors.mainGreen,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () {
                final authRepository = AuthRepository();

                authRepository.signOut();
              },
              child: Row(
                children: [
                  const SizedBox(width: 40),
                  Text(
                    'Sair',
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 40),
                  const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

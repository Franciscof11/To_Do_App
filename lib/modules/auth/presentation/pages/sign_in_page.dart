import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:to_do_app/modules/auth/data/auth_repository.dart';
import 'package:to_do_app/modules/auth/presentation/pages/sign_up_page.dart';
import 'package:to_do_app/modules/auth/presentation/widgets/apple_sign_in_button.dart';
import 'package:to_do_app/modules/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:to_do_app/utils/app_colors.dart';
import 'package:to_do_app/utils/custom_text_field.dart';
import 'package:to_do_app/utils/remove_glow_effect.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: RemoveGlowEffect(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  //
                  Icon(
                    Icons.task_outlined,
                    size: 130,
                    color: AppColors.mainGreen,
                  ),
                  //
                  const SizedBox(height: 20),
                  Text(
                    "Bem vindo(a)!",
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(label: 'Email', controller: emailController),
                  const SizedBox(height: 16),
                  CustomTextField(label: 'Senha', isSecret: true, controller: passwordController),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Esqueceu a senha?",
                      style: GoogleFonts.rubik(
                        color: Colors.white60,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  ElevatedButton(
                    onPressed: () {
                      final formValid = formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        AuthRepository().signIn(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 70),
                      backgroundColor: Colors.black,
                      overlayColor: AppColors.mainGreen,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Entrar',
                      style: GoogleFonts.rubik(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainGreen,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const SignUpPage(),
                      ),
                    ),
                    child: Text(
                      "Criar Conta",
                      style: GoogleFonts.rubik(
                        color: Colors.white60,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey[600],
                          thickness: 0.5,
                        ),
                      ),
                      Text(
                        "   Ou continue com   ",
                        style: GoogleFonts.rubik(
                          color: Colors.white60,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey[600],
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GoogleSignInButton(
                        urlImage: 'assets/google.png',
                      ),
                      SizedBox(width: 30),
                      AplleSignInButton(
                        urlImage: 'assets/apple.png',
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

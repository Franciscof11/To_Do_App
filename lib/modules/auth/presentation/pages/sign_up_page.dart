import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:to_do_app/modules/auth/data/auth_repository.dart';
import 'package:to_do_app/modules/auth/presentation/pages/sign_in_page.dart';
import 'package:to_do_app/utils/app_colors.dart';
import 'package:to_do_app/utils/custom_text_field.dart';
import 'package:to_do_app/utils/remove_glow_effect.dart';

import '../widgets/apple_sign_in_button.dart';
import '../widgets/google_sign_in_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formsignUpKey = GlobalKey<FormState>();
  final emailSignUpController = TextEditingController();
  final passwordSignUpController = TextEditingController();
  final confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: RemoveGlowEffect(
        child: SingleChildScrollView(
          child: Form(
            key: formsignUpKey,
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
                    "Vamos criar uma conta para você!",
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 26),
                  CustomTextField(
                    label: 'Email',
                    controller: emailSignUpController,
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    label: 'Senha',
                    isSecret: true,
                    controller: passwordSignUpController,
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    label: 'Confirmar senha',
                    isSecret: true,
                    controller: confirmPassword,
                  ),
                  const SizedBox(height: 45),
                  ElevatedButton(
                    onPressed: () async {
                      final formValid = formsignUpKey.currentState?.validate() ?? false;
                      if (formValid) {
                        if (passwordSignUpController.text == confirmPassword.text) {
                          AuthRepository().signUp(
                            email: emailSignUpController.text,
                            password: passwordSignUpController.text,
                            context: context,
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 240),
                              child: Card(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'As senhas não são iguais!',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 70),
                      backgroundColor: Colors.black,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Criar conta',
                      style: GoogleFonts.rubik(
                        fontSize: 22,
                        color: AppColors.mainGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: const SignInPage(),
                      ),
                    ),
                    child: Text(
                      "Já possui uma conta? Faça Login!",
                      style: GoogleFonts.rubik(
                        color: Colors.white60,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
                      SizedBox(width: 24),
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

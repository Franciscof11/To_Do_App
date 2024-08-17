import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/modules/auth/data/auth_repository.dart';
import 'package:to_do_app/modules/auth/presentation/pages/sign_up_page.dart';
import 'package:to_do_app/modules/auth/presentation/widgets/apple_sign_in_button.dart';
import 'package:to_do_app/modules/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:to_do_app/utils/custom_text_form_field.dart';
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
    double widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: RemoveGlowEffect(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  //
                  const Icon(
                    Icons.lock,
                    size: 140,
                  ),
                  //
                  const SizedBox(height: 20),
                  Text(
                    "Welcome back you've been missed!",
                    style: GoogleFonts.rubik(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 26),
                  CustomTextFormField(label: 'Email', controller: emailController),
                  const SizedBox(height: 16),
                  CustomTextFormField(label: 'Password', isSecret: true, controller: passwordController),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.rubik(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  ElevatedButton(
                    onPressed: () {
                      formKey.currentState?.validate();
                      AuthRepository().signIn(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 80),
                      backgroundColor: Colors.black,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.rubik(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    ),
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.rubik(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: widthDevice <= 380 ? 80 : 100,
                        child: Divider(
                          color: Colors.grey[600],
                          thickness: 0.5,
                        ),
                      ),
                      Text(
                        "Or continue with",
                        style: GoogleFonts.rubik(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        width: widthDevice <= 380 ? 80 : 100,
                        child: Divider(
                          color: Colors.grey[600],
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
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

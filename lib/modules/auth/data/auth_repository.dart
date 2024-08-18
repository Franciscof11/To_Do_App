import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:to_do_app/config/database/tasks/tasks_db.dart';
import 'package:to_do_app/modules/auth/presentation/pages/sign_in_page.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/home_page/cubit/home_page_cubit.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/home_page/home_page.dart';

class AuthRepository {
  Widget authChanges(BuildContext context) {
    return StreamBuilder<User?>(
      // Escuta se o user está logado ou não
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // usuário logado
        if (snapshot.hasData) {
          return RepositoryProvider(
            create: (context) => TasksDB(),
            child: BlocProvider(
              create: (context) => HomePageCubit(repository: context.read<TasksDB>())..getAllTasks(),
              child: const HomePage(),
            ),
          );
        }
        // usuário não está  logado
        else {
          return const SignInPage();
        }
      },
    );
  }

  signInWithApple() async {
    final appleProvider = AppleAuthProvider();

    await FirebaseAuth.instance.signInWithProvider(appleProvider);
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pop(context);
      //
    } on FirebaseAuthException catch (e) {
      print('------------------------------------------');
      print(e.code);
      Navigator.pop(context);
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        print('###########################');
        print('Invalid Credentials!');

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
                      'Invalid Credentials!',
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
  }

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    } on FirebaseAuthException catch (e) {
      print('###########################');
      print(e.code);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
  }
}

import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:to_do_app/config/database/tasks/tasks_db.dart';
import 'package:to_do_app/modules/auth/data/auth_repository.dart';
import 'package:to_do_app/modules/to_do/data/task_repository.dart';
import 'package:to_do_app/modules/to_do/domain/task.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  deploymentRoutine() {
    final taskDB = TasksDB();

    final tasksRepository = TaskRepository();

    Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        final List<Task> tasks = await taskDB.getAllTasks();

        await tasksRepository.postToFirestore(tasks: tasks);

        debugPrint('#Sucess deploy routine!');
        debugPrint(tasks.toString());
        debugPrint('');
        debugPrint('#Cleaning leads table...');
      },
    );
  }

  @override
  void initState() {
    super.initState();
    deploymentRoutine();
  }

  @override
  Widget build(BuildContext context) {
    final authFirebaseRepository = AuthRepository();
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/splash.json'),
      pageTransitionType: PageTransitionType.fade,
      splashTransition: SplashTransition.fadeTransition,
      duration: 4100,
      backgroundColor: const Color.fromRGBO(228, 240, 246, 1),
      splashIconSize: 80000,
      nextScreen: authFirebaseRepository.authChanges(context),
    );
  }
}

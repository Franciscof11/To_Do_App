import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/firebase_options.dart';
import 'package:to_do_app/modules/to_do/data/task_repository.dart';
import 'package:to_do_app/modules/to_do/presentation/pages/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isFirstTime = prefs.getBool('isFirstTime') ?? true; // Valida se é a primeira vez que o usuário abre o app.

  runApp(
    DevicePreview(
      enabled: true, // Ativa ou não o Device Preview //
      builder: (context) => MainApp(isFirstTime: isFirstTime),
    ),
  );
}

class MainApp extends StatelessWidget {
  final bool isFirstTime;
  const MainApp({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TaskRepository(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(isFirstTime: isFirstTime),
      ),
    );
  }
}

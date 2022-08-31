// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tripping/screens/home_screen.dart';
import 'package:tripping/screens/login_screen.dart';
import 'package:tripping/utils/color.dart';
import 'package:tripping/utils/path.dart';

class PlashScreen extends StatelessWidget {
  const PlashScreen({Key? key}) : super(key: key);

  void loadWelcomeScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    await Firebase.initializeApp();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return const HomeScreen();
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    loadWelcomeScreen(context);

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Image.asset(logo02Path),
      ),
    );
  }
}

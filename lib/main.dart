import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripping/screens/plash_screen.dart';
import 'package:tripping/utils/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: whiteColor,
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      ),
      home: const PlashScreen(),
    );
  }
}

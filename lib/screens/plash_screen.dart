import 'package:flutter/material.dart';
import 'package:tripping/utils/color.dart' as color;
import 'package:tripping/utils/path.dart' as path;

class PlashScreen extends StatelessWidget {
  const PlashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.primaryColor,
      child: Image.asset(path.logo02Path),
    );
  }
}

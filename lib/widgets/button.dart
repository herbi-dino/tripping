import 'package:flutter/material.dart';
import 'package:tripping/utils/color.dart';

class Button extends StatelessWidget {
  final VoidCallback onClick;
  final String text;

  const Button({
    Key? key,
    required this.onClick,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 8,
      ),
      width: double.infinity,
      child: TextButton(
        onPressed: onClick,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(primaryColor),
          foregroundColor: MaterialStateProperty.all(whiteColor),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

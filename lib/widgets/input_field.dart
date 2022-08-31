import 'package:flutter/material.dart';
import 'package:tripping/utils/color.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String hintText;
  final TextInputType inputType;

  const InputField({
    Key? key,
    required this.controller,
    required this.isPassword,
    required this.hintText,
    required this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: Divider.createBorderSide(context),
    );

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 8,
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 16,
          color: blackColor,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: border,
          focusedBorder: border,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        keyboardType: inputType,
        obscureText: isPassword,
      ),
    );
  }
}

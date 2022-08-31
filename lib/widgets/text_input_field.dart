import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String hintText;
  final TextInputType inputType;

  const TextInputField({
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
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: border,
          focusedBorder: border,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
        ),
        keyboardType: inputType,
        obscureText: isPassword,
      ),
    );
  }
}

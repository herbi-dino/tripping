// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tripping/firebase/auth_firebase.dart';
import 'package:tripping/screens/home_screen.dart';
import 'package:tripping/screens/login_screen.dart';
import 'package:tripping/utils/color.dart';
import 'package:tripping/utils/path.dart';
import 'package:tripping/utils/utils.dart';
import 'package:tripping/widgets/button.dart';
import 'package:tripping/widgets/input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  void signUp() async {
    try {
      await AuthFirebase().signUpUser(
        email: _emailCtrl.text,
        password: _passwordCtrl.text,
        name: _nameCtrl.text,
        avatarFile: null,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  void switchToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(logo01Path),
              InputField(
                controller: _nameCtrl,
                isPassword: false,
                hintText: 'Name',
                inputType: TextInputType.text,
              ),
              InputField(
                controller: _emailCtrl,
                isPassword: false,
                hintText: 'Email',
                inputType: TextInputType.emailAddress,
              ),
              InputField(
                controller: _passwordCtrl,
                isPassword: true,
                hintText: 'Password',
                inputType: TextInputType.text,
              ),
              Button(
                onClick: signUp,
                text: 'Sign up',
              ),
              InkWell(
                onTap: switchToLogin,
                child: const Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontSize: 14,
                    color: blackColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

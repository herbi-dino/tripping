// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tripping/firebase/auth_firebase.dart';
import 'package:tripping/screens/home_screen.dart';
import 'package:tripping/utils/color.dart';
import 'package:tripping/utils/path.dart';
import 'package:tripping/utils/utils.dart';
import 'package:tripping/widgets/button.dart';
import 'package:tripping/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _emailCtrl.dispose();
    _passwordCtrl.dispose();
  }

  void login() async {
    try {
      await AuthFirebase().loginUser(
        email: _emailCtrl.text,
        password: _passwordCtrl.text,
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
                onClick: login,
                text: 'Login',
              ),
              InkWell(
                child: const Text(
                  'Sign up for an account?',
                  style: TextStyle(
                    fontSize: 14,
                    color: blackColor,
                  ),
                ),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

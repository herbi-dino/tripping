import 'package:flutter/material.dart';
import 'package:tripping/firebase/auth.dart';
import 'package:tripping/utils/path.dart';
import 'package:tripping/widgets/text_input_field.dart';

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
    await Auth().loginUser(
      email: _emailCtrl.text,
      password: _passwordCtrl.text,
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
              TextInputField(
                controller: _emailCtrl,
                isPassword: false,
                hintText: 'Email',
                inputType: TextInputType.emailAddress,
              ),
              TextInputField(
                controller: _passwordCtrl,
                isPassword: true,
                hintText: 'Password',
                inputType: TextInputType.text,
              ),
              InkWell(
                child: const Text('Sign up for an account'),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

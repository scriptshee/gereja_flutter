import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/pages/auth/register.dart';
import 'package:gereja_flutter/pages/home.dart';
import 'package:gereja_flutter/themes/components/elevatedButton.dart';
import 'package:gereja_flutter/themes/components/textinput.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Homepage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.0.sp),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SimpleTextField(
              labelText: 'Email',
              textEditingController: _emailController,
              prefixIconData: Icons.email,
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.sp),
            SimpleTextField(
              labelText: 'Password',
              textEditingController: _passwordController,
              prefixIconData: Icons.lock,
              obscureText: true,
            ),
            SizedBox(height: 20.sp),
            SizedBox(
              width: double.infinity,
              child: SimpleElevatedButton(
                onPressed: _submitForm,
                color: Colors.blue,
                child: const Text(
                  'Masuk',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10.sp),
            TextButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const RegisterPage(),
                  ),
                );
              },
              child: Text("Daftar"),
            ),
          ],
        ),
      ),
    );
  }
}

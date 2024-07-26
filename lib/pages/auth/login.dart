import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/pages/auth/register.dart';
import 'package:gereja_flutter/pages/home.dart';
import 'package:gereja_flutter/services/auth_services.dart';
import 'package:gereja_flutter/themes/components/elevatedButton.dart';
import 'package:gereja_flutter/themes/components/textinput.dart';
import 'package:gereja_flutter/utils/use_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final api = AuthServices();
  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    final resp = await api.login({
      "email": _emailController.text,
      "password": _passwordController.text,
    }, context);

    if (resp.statusCode == 200) {
      await Store.setToken(resp.data!['access_token']);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Homepage(),
        ),
      );
    }
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
            Image(
              image: const AssetImage('assets/logo_gereja.png'),
              width: 100.sp,
            ),
            SizedBox(height: 10.sp),
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
                color: Colors.indigo,
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
              child: const Text(
                "Daftar",
                style: TextStyle(color: Colors.indigo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

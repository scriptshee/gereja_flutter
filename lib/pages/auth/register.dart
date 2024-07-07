import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/themes/components/elevatedButton.dart';
import 'package:gereja_flutter/themes/components/textinput.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
    if (_formKey.currentState!.validate()) {
      // String name = _passwordController.text;
      // String email = _emailController.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24.0.sp),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleTextField(
                labelText: 'Nama',
                textEditingController: _emailController,
                prefixIconData: Icons.email,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.sp),
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
                  color: Colors.green[600],
                  child: const Text(
                    'Daftar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10.sp),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.green[600]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

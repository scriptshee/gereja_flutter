import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/services/auth_services.dart';
import 'package:gereja_flutter/themes/components/elevatedButton.dart';
import 'package:gereja_flutter/themes/components/textinput.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final api = AuthServices();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String password = _passwordController.text;
      String email = _emailController.text;

      var resp = await api.register({
        "name": name,
        "email": email,
        "password": password,
      }, context);

      if (resp.statusCode == 201) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Berhasil ! user telah terdaftar'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ));
      }
    } else {
      print('not validate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24.0.sp),
        child: SingleChildScrollView(
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
                SizedBox(height: 20.sp),
                SimpleTextField(
                  labelText: 'Nama',
                  textEditingController: _nameController,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20.sp),
                SimpleTextField(
                  labelText: 'Email',
                  textEditingController: _emailController,
                  prefixIconData: Icons.mark_email_read,
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
      ),
    );
  }
}

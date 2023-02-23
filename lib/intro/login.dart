import "package:flutter/material.dart";

import 'package:to_do_clone/intro/forgot_password.dart';

import '../screens/landing.dart';
import '../service/auth.dart';
import 'sign_up.dart';

class Login extends StatefulWidget {
  static const String id = "/login_page";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  late final GlobalKey<FormState> formKey;
  late final GlobalKey<ScaffoldState> scaffoldKey;
  late final TextEditingController email;
  late final TextEditingController password;

  loginUser() async {
    formKey.currentState!.validate();
    setState(() => _isLoading = true);
    var response = await Authentication.loginUser(email.text, password.text);

    if (response != null && mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(response),
        ),
      );
    }
    setState(() => _isLoading = false);
    if (response == null && mounted) {
      Navigator.of(context).pushNamed(MainPage.id);
    }
    email.clear();
    password.clear();
  }

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    scaffoldKey = GlobalKey<ScaffoldState>();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    formKey.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 300),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                controller: email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannnot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: const Text('Email'),
                  hintText: 'myemail@gmail.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: password,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be empty";
                  } else if (value.length < 8) {
                    return "Password cannot be less than 8 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: const Text('Password'),
                  hintText: '12345678',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(ForgotPassword.id),
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: _isLoading ? null : () async => await loginUser(),
                icon: _isLoading
                    ? const CircularProgressIndicator()
                    : const Icon(Icons.arrow_right_alt_rounded),
                label: _isLoading ? const Text('') : const Text('Login'),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Don't have an account? "),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(SignUp.id),
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}

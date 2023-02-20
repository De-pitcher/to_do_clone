import "package:flutter/material.dart";
import '../../service/auth.dart';
import 'sign_up.dart';
import '../landing.dart';
import '../../widgets/error_widget.dart';

class Login extends StatefulWidget {
  static const String id = "/login_page";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  final Authentication _authentication = Authentication();
  late final GlobalKey<FormState> formKey;
  late final GlobalKey<ScaffoldState> scaffoldKey;
  late final TextEditingController email;
  late final TextEditingController password;

  Future<void> loginUser() async {
    formKey.currentState!.validate();
    setState(() => _isLoading = true);
    try {
      await _authentication
          .loginUser(email.text, password.text)
          .whenComplete(() => Navigator.of(context).pushNamed(MainPage.id));
    } catch (error) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppError(error: error.toString()),
        ),
      );
    }
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
              const SizedBox(height: 15),
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

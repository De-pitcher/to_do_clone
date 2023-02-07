import "package:flutter/material.dart";
import 'package:to_do_clone/screens/landing.dart';

class Login extends StatefulWidget {
  static const String id = "/login_page";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String buttonText;
  late final GlobalKey<FormState> formKey;
  late final GlobalKey<ScaffoldState> scaffoldKey;
  late final TextEditingController email;
  late final TextEditingController password;

  @override
  void initState() {
    super.initState();
    buttonText = 'Login';
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
                onPressed: () {
                  bool validDetails = formKey.currentState!.validate();
                  if (validDetails) {
                    setState(() => buttonText = 'Welcome Back');
                  
                    Navigator.of(context).pushNamed(MainPage.id);
                  } else {
                    scaffoldKey.currentState!.showBottomSheet((context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        color: Colors.red[400],
                        child: const Center(
                          child: Text('Incorrect email or password'),
                        ),
                      );
                    });
                  }
                },
                icon: const Icon(Icons.arrow_right_alt_rounded),
                label: Text(buttonText),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          const Text("Don't have an account? "),
          TextButton(
            onPressed: () {},
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}

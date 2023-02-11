import "package:flutter/material.dart";
import 'package:to_do_clone/data/firebase_auth.dart';
import 'package:to_do_clone/intro/sign_up.dart';
import 'package:to_do_clone/screens/landing.dart';
import 'package:to_do_clone/widgets/error_widget.dart';

class Login extends StatefulWidget {
  static const String id = "/login_page";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Authentication _auth = Authentication();
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
              FutureBuilder(
                builder: (context, snapshot) {
                  
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // scaffoldKey.currentState!.showBottomSheet(
                    //   (context) => AppError(error: snapshot.error.toString()),
                    // );
                    print(snapshot.error);
                  }
                  // if (snapshot.connectionState == ConnectionState.done) {
                  //   // setState(() => buttonText = 'Welcome Back');
                  //   // Navigator.of(context).pushNamed(MainPage.id);
                  // }
                  return TextButton.icon(
                    onPressed: () async {
                      formKey.currentState!.validate();
                      await _auth.loginUser(email.text, password.text);
                    },
                    icon: const Icon(Icons.arrow_right_alt_rounded),
                    label: Text(buttonText),
                  );
                },
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

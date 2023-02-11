import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:to_do_clone/intro/login.dart';
import 'package:to_do_clone/widgets/error_widget.dart';

class SignUp extends StatefulWidget {
  static const String id = "/sign_up";
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth ins = FirebaseAuth.instance;

  late final GlobalKey<FormState> formKey;
  late final GlobalKey<ScaffoldState> scaffoldKey;
  late final TextEditingController name;
  late final TextEditingController email;
  late final TextEditingController password;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    scaffoldKey = GlobalKey<ScaffoldState>();
    email = TextEditingController();
    name = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    name.dispose();
    password.dispose();
    scaffoldKey.currentState!.dispose();
    formKey.currentState!.dispose();
    super.dispose();
  }

  Future createAccount(
      {required String email, required String password}) async {
    await ins.createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 200),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                controller: name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Name cannnot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: const Text('Name'),
                  hintText: 'John Doe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError == true) {
                    scaffoldKey.currentState!.showBottomSheet(
                      (context) => AppError(
                        error: snapshot.error.toString(),
                      ),
                    );
                  }
                  return TextButton(
                    onPressed: () async {
                      bool validDetails = formKey.currentState!.validate();
                      if (validDetails) {
                        await createAccount(
                                email: email.text, password: password.text)
                            .then((value) =>
                                Navigator.of(context).pushNamed(Login.id));
                      }
                    },
                    child: const Text('Sign up'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

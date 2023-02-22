import "package:flutter/material.dart";
import 'login.dart';
import '../service/auth.dart';


class SignUp extends StatefulWidget {
  static const String id = "/sign_up";
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isLoading = false;

  late final GlobalKey<FormState> formKey;
  late final GlobalKey<ScaffoldState> scaffoldKey;
  late final TextEditingController name;
  late final TextEditingController email;
  late final TextEditingController password;

  createUser() async {
    formKey.currentState!.validate();
    setState(() => _isLoading = true);
    var response =
        await Authentication.createAccount(email.text, password.text);

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
      Navigator.of(context).pushNamed(Login.id);
    }
    name.clear();
    email.clear();
    password.clear();
  }

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
              TextButton(
                onPressed: _isLoading ? null : () async => await createUser(),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Sign up'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

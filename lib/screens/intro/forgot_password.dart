import 'package:flutter/material.dart';

import '../../service/auth.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = '/forgot_password';
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _isLoading = false;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController password;
  late final TextEditingController cPassword;

  resetPassword() async {
    formKey.currentState!.validate();
    setState(() => _isLoading = true);
    var response = await Authentication.resetPassword(cPassword.text);
    if (response != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response),
        ),
      );
    }
    setState(() => _isLoading = false);
    if (response == null && mounted) {
      // Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    password = TextEditingController();
    cPassword = TextEditingController();
  }

  @override
  void dispose() {
    password.dispose();
    cPassword.dispose();
    formKey.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 300),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                controller: password,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannnot be empty";
                  } else if (value.length < 8) {
                    return "Password cannot be less than 8 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: const Text('New Password'),
                  hintText: '12345678',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: cPassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be empty";
                  } else if (value.length < 8) {
                    return "Password cannot be less than 8 characters";
                  } else if (value != password.value.text) {
                    return "Password entered must be the same.";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: const Text('Confirm new password'),
                  hintText: '12345678',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: _isLoading ? null : () async => await resetPassword(),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

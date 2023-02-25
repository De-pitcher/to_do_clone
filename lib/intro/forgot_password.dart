import 'package:flutter/material.dart';

import '../service/auth.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = '/forgot_password';
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _isLoading = false;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController email;

  sendResetLink() async {
    formKey.currentState!.validate();
    setState(() => _isLoading = true);
    var response = await Authentication.resetPassword(email.text);

    if (response != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[300],
          content: Text(response),
        ),
      );
    }
    setState(() => _isLoading = false);

    if (response == null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green[300],
          content: const Text('Successfully sent reset link'),
        ),
      );
    }

    if (response == null && mounted) {
      Navigator.of(context).pop();
    }
    email.clear();
  }

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    email.dispose();
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
                controller: email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter a email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: const Text('Enter email'),
                  hintText: 'johndoe@gmail.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed:
                    _isLoading ? null : () async => await sendResetLink(),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Send Reset Link'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

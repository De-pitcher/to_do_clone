import "package:flutter/material.dart";

class AddAccount extends StatefulWidget {
  static const String id = "/profile/add_account";
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add account"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Email or phone number",
                  hintStyle: TextStyle(color: Colors.black54),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20)),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.black,
                  alignment: Alignment.center,
                  fixedSize: Size(MediaQuery.of(context).size.width, 45)),
              child: const Text("Sign in"),
            ),
            const SizedBox(height: 20),
            const Text("Sign in with a work, or Microsoft account")
          ],
        ),
      ),
      bottomSheet: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
            foregroundColor: Colors.blue[800],
            alignment: Alignment.center,
            fixedSize: Size(MediaQuery.of(context).size.width, 20)),
        child: const Text("Create a new account"),
      ),
    );
  }
}

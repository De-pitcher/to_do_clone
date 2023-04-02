import 'package:flutter/material.dart';
import 'package:to_do_clone/screens/manage_account/add_account.dart';

class Accounts extends StatefulWidget {
  static const String id = "/profile/accounts";
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  Widget account({required String name, required String email}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const CircleAvatar(
            child: Placeholder(),
          ),
          title: Text(name),
          subtitle: Text(
            email,
            style: const TextStyle(color: Colors.white24),
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: Colors.red[900],
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            fixedSize: const Size(200, 50),
          ),
          child: const Text("SIGN OUT"),
        ),
        const Divider()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Manage accounts'),
      ),
      body: ListView(
        children: [
          account(name: "user name", email: "user email"),
          TextButton.icon(
            onPressed: () => Navigator.of(context).popAndPushNamed(AddAccount.id),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25)
            ),
            icon: const Icon(Icons.add),
            label: const Text('Add account'),
          )
        ],
      ),
    );
  }
}

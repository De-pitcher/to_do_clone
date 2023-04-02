import 'package:flutter/material.dart';
import 'package:to_do_clone/service/auth.dart';

class Settings extends StatelessWidget {
  static const String id = "profile/settings";
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 45,
                      child: Placeholder(),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(
                      title: Text("user name"),
                      subtitle: Text("user email"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 6),
                    ),
                    const Divider(indent: 10),
                    TextButton(
                      onPressed: () {},
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.white),
                      child: const Text("MANAGE ACCOUNT"),
                    ),
                    const Divider(indent: 10),
                    TextButton(
                      onPressed: () async => await Authentication.signOut(),
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: const Text("SIGN OUT"),
                    )
                  ],
                ),
              )
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}

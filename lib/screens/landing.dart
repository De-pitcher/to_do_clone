import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_clone/screens/profile.dart';
import 'package:to_do_clone/widgets/actions_widget.dart';

class MainPage extends StatefulWidget {
  static const String id = '/';
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              onTap: () => Navigator.of(context).pushNamed(ProfileAccount.id),
              leading: const CircleAvatar(),
              title: const Text(
                'Name',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                'Email of user',
                style: TextStyle(color: Colors.white38),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: Colors.white38, size: 32),
              ),
            ),
            Flexible(
              child: ListView(
                children: [
                  ActionWidget(
                    icon: CupertinoIcons.brightness,
                    iconColor: Colors.purple[400],
                    action: 'My Day',
                  ),
                  ActionWidget(
                    icon: CupertinoIcons.star,
                    iconColor: Colors.pink[200],
                    action: 'Important',
                  ),
                  ActionWidget(
                    icon: Icons.schedule,
                    iconColor: Colors.cyan[300],
                    action: 'Planned',
                  ),
                  ActionWidget(
                    icon: CupertinoIcons.person,
                    iconColor: Colors.teal[200],
                    action: 'Assigned to me',
                  ),
                  ActionWidget(
                    icon: CupertinoIcons.home,
                    iconColor: Colors.deepPurple[300],
                    action: 'Tasks',
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    onTap: () {},
                    leading: Icon(Icons.add, color: Colors.grey[700]),
                    title: Text(
                      'New list',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.note_add_outlined, color: Colors.grey[700]),
                  style: IconButton.styleFrom(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

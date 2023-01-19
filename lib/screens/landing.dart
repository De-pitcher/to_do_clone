import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'activities/assigned_to_me.dart';
import 'activities/important.dart';
import 'activities/my_day.dart';

import 'profile.dart';
import 'list_screen.dart';
import '../widgets/actions_widget.dart';

import 'activities/planned.dart';
import 'activities/tasks.dart';

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
                    routeName: MyDay.id,
                  ),
                  ActionWidget(
                    icon: CupertinoIcons.star,
                    iconColor: Colors.pink[200],
                    action: 'Important',
                    routeName: Important.id,
                  ),
                  ActionWidget(
                    icon: Icons.schedule,
                    iconColor: Colors.cyan[300],
                    action: 'Planned',
                    routeName: Planned.id,
                  ),
                  ActionWidget(
                    icon: CupertinoIcons.person,
                    iconColor: Colors.teal[200],
                    action: 'Assigned to me',
                    routeName: AssignedPage.id,
                  ),
                  ActionWidget(
                    icon: CupertinoIcons.home,
                    iconColor: Colors.deepPurple[300],
                    action: 'Tasks',
                    routeName: Tasks.id,
                    
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    onTap: () => Navigator.of(context).pushNamed(ListScreen.id),
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

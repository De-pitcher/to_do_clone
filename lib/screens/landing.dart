import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './profile.dart';
import './list_screen.dart';
import '../screens/activities/assigned_to_me.dart';
import '../screens/activities/important.dart';
import '../screens/activities/my_day.dart';
import '../screens/activities/planned.dart';
import '../screens/activities/tasks.dart';
import '../widgets/dialogs/group_dialog.dart';
import '../widgets/actions_widget.dart';
import '../widgets/draggable_list_widget.dart';

class MainPage extends StatelessWidget {
  static const String id = '/';
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              child: Column(
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
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const Expanded(
                    child: DraggableListWidget(),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    onTap: () => Navigator.of(context).pushNamed(ListScreen.id),
                    leading: const Icon(Icons.add, color: Colors.white),
                    title: const Text(
                      'New list',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(
                          'Create a group',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        content: const GroupDialog(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.note_add_outlined,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

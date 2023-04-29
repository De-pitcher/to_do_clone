import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/important_tasks.dart';
import '../providers/my_day_tasks.dart';
import '../providers/planned_tasks.dart';
import '../providers/tasks.dart';
import './profile.dart';
import './list_screen.dart';
import '../screens/activities/assigned_to_me.dart';
import './activities/important_screen.dart';
import './activities/my_day_screen.dart';
import 'activities/planned_screen.dart';
import './activities/tasks_screen.dart';
import '../widgets/dialogs/group_dialog.dart';
import '../widgets/actions_widget.dart';
import '../widgets/draggable_list_widget.dart';
import '../providers/groups.dart';

class MainPage extends StatelessWidget {
  static const String id = '/main_page';
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white10,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              onTap: () => Navigator.of(context).pushNamed(ProfileAccount.id),
              leading: const CircleAvatar(
                backgroundColor: Colors.grey,
              ),
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
                  //* [MyDay] tile
                  ActionWidget(
                    icon: CupertinoIcons.brightness,
                    iconColor: Colors.cyanAccent[100],
                    activity: 'My Day',
                    routeName: MyDayScreen.id,
                    counter:
                        Provider.of<MyDayTasks>(context).undoneTasks.length,
                  ),
                  //* [Important] tile
                  ActionWidget(
                    icon: CupertinoIcons.star,
                    iconColor: Colors.pink[200],
                    activity: 'Important',
                    routeName: ImportantScreen.id,
                    counter: Provider.of<ImportantTasks>(context)
                        .undoneTasks
                        .length,
                  ),
                  //* [Planned] tile
                  ActionWidget(
                    icon: Icons.schedule,
                    iconColor: Colors.cyan[300],
                    activity: 'Planned',
                    routeName: PlannedScreen.id,
                    counter: Provider.of<PlannedTasks>(context).tasks.length,
                  ),
                  //* [Assigned to me] tile
                  ActionWidget(
                    icon: CupertinoIcons.person,
                    iconColor: Colors.teal[200],
                    activity: 'Assigned to me',
                    routeName: AssignedPage.id,
                  ),
                  //* [Tasks] tile
                  ActionWidget(
                    icon: CupertinoIcons.home,
                    iconColor: Colors.deepPurple[300],
                    activity: 'Tasks',
                    routeName: TasksScreen.id,
                    counter: Provider.of<Tasks>(context).undoneTasks.length,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  //* Displays the lists and groups of lists
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
                        content: GroupDialog(
                          onCreatePressed: (title) {
                            Provider.of<Groups>(context, listen: false)
                                .createGroup(title, []);
                          },
                        ),
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

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import './providers/list_theme.dart';
import './providers/activities.dart';
import './providers/groups.dart';
import './providers/tasks.dart';
import './providers/task_steps.dart';
import 'providers/add_due_date_list.dart';
import 'providers/important_tasks.dart';
import 'providers/my_day_tasks.dart';
import 'utils/routes/routes.dart';
import './utils/res/theme.dart';
import '../screens/intro/login.dart';
import 'screens/main_page.dart';
import '../service/auth.dart';
import './providers/remind_me_list.dart';
import 'providers/planned_tasks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ToDoClone());
}

class ToDoClone extends StatelessWidget {
  const ToDoClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListTheme>(
          create: (_) => ListTheme(),
        ),
        ChangeNotifierProvider<Activities>(
          create: (_) => Activities(),
        ),
        ChangeNotifierProvider<Groups>(
          create: (_) => Groups(),
        ),
        ChangeNotifierProvider<Tasks>(
          create: (_) => Tasks(),
        ),
        ChangeNotifierProxyProvider<Tasks, PlannedTasks>(
          create: (_) => PlannedTasks(),
          update: (_, tasksProvider, __) =>
              PlannedTasks()..initTasks(tasksProvider.tasks),
        ),
        ChangeNotifierProxyProvider<Tasks, MyDayTasks>(
          create: (_) => MyDayTasks(),
          update: (_, tasksProvider, __) =>
              MyDayTasks()..initTasks(tasksProvider.tasks),
        ),
        ChangeNotifierProxyProvider<Tasks, ImportantTasks>(
          create: (_) => ImportantTasks(),
          update: (_, tasksProvider, __) =>
              ImportantTasks()..initTasks(tasksProvider.tasks),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskSteps(),
        ),
        ChangeNotifierProvider(
          create: (_) => RemindMeList(),
        ),
        ChangeNotifierProvider(
          create: (_) => AddDueDateList(),
        ),
      ],
      child: MaterialApp(
        title: 'ToDo Clone',
        theme: AppTheme.darkTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: Authentication.isSignedIn() ? MainPage.id : Login.id,
        onGenerateRoute: routeGen,
      ),
    );
  }
}

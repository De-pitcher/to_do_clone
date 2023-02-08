import 'package:flutter/material.dart';

import 'package:to_do_clone/providers/tasks.dart';
import 'package:to_do_clone/providers/task_steps.dart';
import 'package:to_do_clone/providers/task_tile.dart';
import 'utils/res/theme.dart';
import 'package:provider/provider.dart';

import './screens/landing.dart';
import './providers/app_color.dart';
import './providers/activities.dart';
import './providers/groups.dart';
import './utils/constants/routes.dart';

void main() {
  runApp(const ToDoClone());
}

class ToDoClone extends StatelessWidget {
  const ToDoClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppColor>(
          create: (_) => AppColor(),
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
        ChangeNotifierProvider<TaskTileState>(
          create: (_) => TaskTileState(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskSteps(),
        ),
      ],
      child: MaterialApp(
        title: 'ToDo Clone',
        theme: ThemeData.dark(),
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: MainPage.id,
        onGenerateRoute: routeGen,
      ),
    );
  }
}

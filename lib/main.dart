import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/list_theme.dart';
import './providers/activities.dart';
import './providers/groups.dart';
import './providers/tasks.dart';
import './providers/task_steps.dart';
import './utils/constants/routes.dart';
import './utils/res/theme.dart';
import './screens/landing and auth/splash_screen.dart';

void main() {
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
        ChangeNotifierProvider(
          create: (_) => TaskSteps(),
        ),
      ],
      child: MaterialApp(
        title: 'ToDo Clone',
        theme: ThemeData.dark(),
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.id,
        onGenerateRoute: routeGen,
      ),
    );
  }
}

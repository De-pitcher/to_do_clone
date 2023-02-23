import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_clone/intro/login.dart';

import 'firebase_options.dart';

import 'providers/activities.dart';
import 'providers/app_color.dart';
import 'providers/groups.dart';
import 'providers/task_steps.dart';
import 'providers/tasks.dart';
import 'screens/landing.dart';
import 'service/auth.dart';
import 'utils/constants/routes.dart';
import 'utils/res/theme.dart';

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
        ChangeNotifierProvider(
          create: (_) => TaskSteps(),
        ),
      ],
      child: MaterialApp(
        title: 'ToDo Clone',
        theme: ThemeData.dark(),
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: Authentication.isSignedIn() ? MainPage.id : Login.id,
        onGenerateRoute: routeGen,
      ),
    );
  }
}

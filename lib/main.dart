import 'package:flutter/material.dart';
import 'package:to_do_clone/res/theme.dart';
import 'package:to_do_clone/screens/activities/tasks.dart';
import 'package:to_do_clone/screens/landing.dart';
import 'package:to_do_clone/screens/profile.dart';

void main() {
  runApp(const ToDoClone());
}

class ToDoClone extends StatelessWidget {
  const ToDoClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo Clone',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: MainPage.id,
      routes: {
        MainPage.id: (context) => const MainPage(),
        ProfileAccount.id: (context) => const ProfileAccount(),
        Tasks.id: (context) => const Tasks(),
      },
    );
  }
}

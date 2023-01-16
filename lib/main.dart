import 'package:flutter/material.dart';
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
      theme: ThemeData(
        brightness: Brightness.dark,
         textTheme:
        TextTheme(
      headline5: TextStyle(color: Colors.deepPurpleAccent),
      headline2: TextStyle(color: Colors.deepPurpleAccent),
      bodyText2: TextStyle(color: Colors.deepPurpleAccent),
      subtitle1: TextStyle(color: Colors.pinkAccent),
    ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: MainPage.id,
      routes: {
        MainPage.id : (context) => const MainPage(),
        ProfileAccount.id: (context) => const ProfileAccount(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/landing.dart';
import './screens/profile.dart';
import './screens/list_screen.dart';
import './providers/app_color.dart';

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
      ],
      child: MaterialApp(
        title: 'ToDo Clone',
        theme: ThemeData(
          brightness: Brightness.dark,
          textTheme: const TextTheme(
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
          MainPage.id: (context) => const MainPage(),
          ProfileAccount.id: (context) => const ProfileAccount(),
          ListScreen.id: (_) => const ListScreen()
        },
      ),
    );
  }
}

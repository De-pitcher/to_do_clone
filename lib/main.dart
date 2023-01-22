import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/landing.dart';
import '../providers/app_color.dart';
import '../providers/activities.dart';
import '../utils/res/theme.dart';
import '../utils/constants/routes.dart';

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

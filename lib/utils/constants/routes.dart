import 'package:flutter/material.dart';

import '../../screens/intro/login.dart';
import '../../screens/intro/sign_up.dart';
import '../../widgets/task_details.dart';
import '../../screens/activities/assigned_to_me.dart';
import '../../screens/activities/important_screen.dart';
import '../../screens/activities/my_day_screen.dart';
import '../../screens/activities/planned_screen.dart';
import '../../screens/activities/tasks_screen.dart';
import '../../screens/landing.dart';
import '../../screens/list_screen.dart';
import '../../screens/profile.dart';

MaterialPageRoute routeGen(RouteSettings settings) {
  switch (settings.name) {
    case Login.id:
      return MaterialPageRoute(builder: (context) => const Login());
    case SignUp.id:
      return MaterialPageRoute(builder: (context) => const SignUp());
    // case ForgotPassword.id:
    //   return MaterialPageRoute(builder: (context) => const ForgotPassword());
    case MainPage.id:
      return MaterialPageRoute(builder: (_) => const MainPage());
    case ProfileAccount.id:
      return MaterialPageRoute(builder: (_) => const ProfileAccount());
    case ListScreen.id:
      return MaterialPageRoute(builder: (_) => const ListScreen());
    case AssignedPage.id:
      return MaterialPageRoute(builder: (_) => const AssignedPage());
    case ImportantScreen.id:
      return MaterialPageRoute(
        builder: (_) => ImportantScreen(
          args: settings.arguments as Map<String, dynamic>,
        ),
      );
    case MyDayScreen.id:
      return MaterialPageRoute(
        builder: (_) => MyDayScreen(
          args: settings.arguments as Map<String, dynamic>,
        ),
      );
    case PlannedScreen.id:
      return MaterialPageRoute(
          builder: (_) => PlannedScreen(
                args: settings.arguments as Map<String, dynamic>,
              ));
    case TasksScreen.id:
      return MaterialPageRoute(
        builder: (_) => TasksScreen(
          args: settings.arguments as Map<String, dynamic>,
        ),
      );
    case TaskDetails.id:
      return MaterialPageRoute(
        builder: (_) =>
            TaskDetails(args: settings.arguments as Map<String, dynamic>),
      );
    default:
      return MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: Text(
                'No Such Page :(',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.deepPurple),
              ),
            ),
          );
        },
      );
  }
}

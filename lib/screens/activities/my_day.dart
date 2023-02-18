import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/tasks.dart';
import '../../widgets/activity_widget.dart';
import '../../widgets/animated_title.dart';
import '../../widgets/buttons/special_button.dart';

class MyDay extends StatefulWidget {
  static const String id = '/my_day';
  const MyDay({super.key});

  @override
  State<MyDay> createState() => _MyDayState();
}

class _MyDayState extends State<MyDay> {
  var _liftTitle = false;
  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<Tasks>(context);
    return SizedBox(
      // height: MediaQuery.of(context).size.height - 10,
      child: ActivityWidget(
        title: 'My Day',
        displaySubtitle: true,
        subtitle: 'Saturday, February 11',
        listModel: tasksProvider.myDayTasks,
        color: Colors.white,
        bgImage: 'assets/images/my_day.png',
        insert: (item, index) => context.read<Tasks>().insert(item, index),
        remove: (index) => context.read<Tasks>().removeTask(index),
        isExtended: true,
        specialButtons: const [
          SpecialButton(
            label: 'Tasks',
            icon: Icons.home_outlined,
          ),
          SpecialButton(
            label: 'Set due date',
            icon: Icons.calendar_month_rounded,
          ),
          SpecialButton(
            label: 'Remind me',
            icon: Icons.notifications_on_outlined,
          ),
          SpecialButton(
            label: 'Repeat',
            icon: Icons.repeat,
          ),
        ],
      ),
    );

    // Scaffold(
    //   extendBodyBehindAppBar: true,
    //   backgroundColor: Colors.transparent,
    //   appBar: AppBar(
    //     toolbarHeight: 40,
    //     elevation: 0,
    //     backgroundColor: Colors.transparent,
    //     leading: IconButton(
    //       icon: const Icon(Icons.arrow_back),
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //         ScaffoldMessenger.of(context).removeCurrentSnackBar();
    //       },
    //     ),
    //     actions: [
    //       IconButton(
    //         onPressed: () {},
    //         icon: const Icon(Icons.more_vert),
    //       ),
    //     ],
    //   ),
    //   body: Container(
    //     constraints: const BoxConstraints.expand(),
    //     decoration: const BoxDecoration(
    //       image: DecorationImage(
    //         image: AssetImage('assets/images/my_day.png'),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     child: SafeArea(
    //       child: Padding(
    //         padding: const EdgeInsets.only(left: 20),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             AnimatedTitle(
    //               driveAnimation: _liftTitle,
    //               title: 'My Day',
    //               displaySubtitle: true,
    //               subtitle: 'Saturday, February 11',
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    //   floatingActionButton: Padding(
    //     padding: const EdgeInsets.only(right: 10),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.end,
    //       children: [
    //         FloatingActionButton.extended(
    //           heroTag: UniqueKey(),
    //           elevation: 5,
    //           onPressed: () {},
    //           label: Row(
    //             children: const [
    //               Icon(Icons.lightbulb_outline_sharp),
    //               SizedBox(width: 10),
    //               Text('Suggestion'),
    //             ],
    //           ),
    //         ),
    //         const SizedBox(width: 50),
    //         FloatingActionButton(
    //           heroTag: UniqueKey(),
    //           elevation: 5,
    //           onPressed: () {
    //             setState(() {
    //               _liftTitle = true;
    //             });
    //           },
    //           child: const Icon(Icons.add),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}

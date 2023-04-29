import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/activities.dart';
import '../providers/tasks.dart';
import '../utils/constants/pop_menu_items.dart';
import 'activity_widget.dart';
import 'buttons/special_button.dart';

class ListWidget extends StatelessWidget {
  /// This is the title of the [ListWidget]
  final String title;

  /// This is the image of the [ListWidget] which can be null when
  /// not specified  but one of the both [image] or [fileImage]
  /// must be specified
  final String? image;

  /// This is the file image of the [ListWidget] which can be null
  /// when not specified but one of the both [image] or [fileImage]
  /// must be specified
  final File? fileImage;

  /// Background color of the [ListWidget]
  final Color color;

  /// A widget that holds the list of [TaskTile]s that contains
  /// lists of tasks
  const ListWidget({
    Key? key,
    required this.title,
    required this.color,
    this.image,
    this.fileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: color,
      elevation: 0,
      toolbarHeight: 40,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.person_add_alt,
            color: color,
          ),
        ),
        PopupMenuButton(
          itemBuilder: (ctx) => popMenuEntries(ctx),
        )
      ],
    );
    final height = appBar.preferredSize.height + 10;
    final activityId = context.read<Activities>().getActivityByTitle(title);

    // return Scaffold(
    //   backgroundColor: const Color.fromARGB(255, 25, 48, 74),
    //   extendBodyBehindAppBar: true,
    //   body: );
    return ActivityWidget(
      title: title,
      activityId: activityId.id,
      displaySubtitle: false,
      appBar: appBar,
      unDoneListModel: Provider.of<Activities>(context).undoneTasks(title),
      completedListModel: const [],
      // Provider.of<Activities>(context).completedTasks(title),
      color: color,
      bgColor: const Color.fromARGB(255, 25, 48, 74),
      insert: (item, index) =>
          // context.read<Tasks>().insert(item, index),
          context.read<Activities>().insert(item, title, index),
      remove: (index) => context.read<Tasks>().removeTask(index),
      bgImage: image,
      fileImage: fileImage,
      emptyWidget: _buildEmptyWidget(height, context),
      isExtended: false,
      fabIcon: const Icon(Icons.add, size: 32),
      specialButtons: const [
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
    );
  }

  Container _buildEmptyWidget(double height, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: image != null
            ? DecorationImage(
                image: AssetImage(image!),
                fit: BoxFit.cover,
              )
            : fileImage != null
                ? DecorationImage(
                    image: FileImage(fileImage!),
                    fit: BoxFit.cover,
                  )
                : null,
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     SizedBox(
      //       height: height,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 16.0),
      //       child: Text(
      //         title,
      //         style: Theme.of(context).textTheme.headline4!.copyWith(
      //               fontWeight: FontWeight.bold,
      //               color: bgColor,
      //             ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

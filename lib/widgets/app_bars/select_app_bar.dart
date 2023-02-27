import 'package:flutter/material.dart';

import '../../models/animated_list_model.dart';
import '../../models/task.dart';
import '../pop_up_menus/select_pop_up_menu.dart';

AppBar selectAppBar({
  required BuildContext context,
  required int count,
  required bool disMarkAsImpt,
  required bool clearAll,
  required AnimatedListModel<Task> undonelistModel,
  required AnimatedListModel<Task> cmpltdListModel,
  Function()? onDelete,
  Function()? onLongPressed,
  Function()? onClearAll,
}) =>
    AppBar(
      elevation: 0,
      backgroundColor: Colors.black,
      leading: IconButton(
        onPressed: onLongPressed,
        icon: const Icon(Icons.cancel_outlined),
      ),
      title: Text('$count'),
      actions: [
        const Icon(Icons.sunny),
        const SizedBox(width: 12),
        const Icon(Icons.task),
        SelectPopUpMenu(
          disMrkAsImpt: disMarkAsImpt,
          onDelete: onDelete,
          clearAll: clearAll,
          onClearAll: onClearAll,
        ),
      ],
    );

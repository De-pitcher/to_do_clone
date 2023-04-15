import 'package:flutter/material.dart';

import '../pop_up_menus/select_pop_up_menu.dart';

AppBar selectAppBar({
  required BuildContext context,
  required int count,
  required bool disMarkAsImpt,
  required bool clearAll,
  required bool hasMyDay,
  required bool isAllSelected,
  Function()? onStar,
  Function()? onSelectAll,
  Function()? onDelete,
  Function()? onCancel,
  Function()? onClearAll,
}) =>
    AppBar(
      elevation: 0,
      backgroundColor: Colors.black,
      leading: IconButton(
        onPressed: onCancel,
        icon: const Icon(Icons.cancel_outlined),
      ),
      title: Text('$count'),
      actions: [
        hasMyDay
            ? const Icon(Icons.task)
            : IconButton(
                icon: const Icon(Icons.sunny),
                onPressed: onStar,
              ),
        const SizedBox(width: 12),
        hasMyDay
            ? isAllSelected
                ? IconButton(
                    onPressed: onCancel,
                    icon: const Icon(Icons.menu),
                  )
                : IconButton(
                    onPressed: onSelectAll,
                    icon: const Icon(Icons.list),
                  )
            : const Icon(Icons.task),
        SelectPopUpMenu(
          disMrkAsImpt: disMarkAsImpt,
          onDelete: onDelete,
          clearAll: clearAll,
          onClearAll: onClearAll,
        ),
      ],
    );

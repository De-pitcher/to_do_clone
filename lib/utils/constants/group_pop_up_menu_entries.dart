import 'package:flutter/material.dart';

import '../../enums/enums.dart';
import '../../widgets/menu_item.dart';

List<PopupMenuEntry<GroupPopMenuValue>> groupPopMenuEntries(
  BuildContext context,
  bool isEmpty,
) =>
    [
      PopupMenuItem(
        value: GroupPopMenuValue.addOrRemove,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.list,
          text: 'Add/Remove lists',
        ),
      ),
      PopupMenuItem(
        value: GroupPopMenuValue.renameGroup,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.task_sharp,
          text: 'Rename group',
        ),
      ),
      isEmpty
          ? PopupMenuItem(
              value: GroupPopMenuValue.deleteGroup,
              textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.white,
                  ),
              child: const PopMenuItem(
                icon: Icons.delete,
                text: 'Delete group',
              ),
            )
          : PopupMenuItem(
              value: GroupPopMenuValue.ungroup,
              textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.white,
                  ),
              child: const PopMenuItem(
                icon: Icons.task_outlined,
                text: 'Ungroup list',
              ),
            ),
    ];

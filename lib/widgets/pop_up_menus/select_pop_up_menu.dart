import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/select_pop_menu_value.dart';
import '../../providers/tasks.dart';
import '../../utils/constants/pop_menu_items.dart';
import '../dialogs/confirm_delete_dialog.dart';

class SelectPopUpMenu extends StatelessWidget {
  final bool disMrkAsImpt;
  final bool clearAll;
  final Function()? onDelete;
  const SelectPopUpMenu(
      {super.key,
      required this.disMrkAsImpt,
      this.onDelete,
      required this.clearAll});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (ctx) => selectPopMenuEntries(ctx, disMrkAsImpt, clearAll),
      onSelected: (value) {
        switch (value) {
          case SelectPopMenuValue.selectAll:
            context.read<Tasks>().setSelectedTaskTo(true);
            break;
          case SelectPopMenuValue.clearAll:
            context.read<Tasks>().setSelectedTaskTo(false);

            break;
          case SelectPopMenuValue.markAsImportant:
            context.read<Tasks>().starSelecedTask();
            break;
          case SelectPopMenuValue.deleteTask:
            showDialog(
                context: context,
                builder: (ctx) {
                  return ConfirmDeleteDialog(onDelete: onDelete);
                });
            break;
          default:
        }
      },
    );
  }
}

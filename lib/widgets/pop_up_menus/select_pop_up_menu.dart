import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/select_pop_menu_value.dart';
import '../../providers/tasks.dart';
import '../../utils/constants/constants.dart';
import '../dialogs/confirm_delete_dialog.dart';

class SelectPopUpMenu extends StatelessWidget {
  final bool disMrkAsImpt;
  final bool clearAll;
  final Function()? onDelete;
  final Function()? onClearAll;
  const SelectPopUpMenu(
      {super.key,
      required this.disMrkAsImpt,
      this.onDelete,
      required this.clearAll,
      this.onClearAll});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (ctx) => selectPopMenuEntries(ctx, disMrkAsImpt, clearAll),
      onSelected: (value) {
        switch (value) {
          case SelectPopMenuValue.selectAll:
            context.read<Tasks>().setAllTaskToSelected(true);
            break;
          case SelectPopMenuValue.clearAll:
            context.read<Tasks>().setAllTaskToSelected(false);
            onClearAll!();
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

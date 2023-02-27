import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/select_pop_menu_value.dart';
import '../../providers/tasks.dart';
import '../../utils/constants/pop_menu_items.dart';

class SelectPopUpMenu extends StatelessWidget {
  final bool disMrkAsImpt;
  final Function()? onDelete;
  const SelectPopUpMenu({super.key, required this.disMrkAsImpt, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (ctx) => selectPopMenuEntries(ctx, disMrkAsImpt),
      onSelected: (value) {
        switch (value) {
          case SelectPopMenuValue.selectAll:
            context.read<Tasks>().setSelectedTaskTo(true);
            break;
          case SelectPopMenuValue.markAsImportant:
            context.read<Tasks>().starSelecedTask();
            break;
          case SelectPopMenuValue.deleteTask:
            showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: const Text('Delete task'),
                    content: SizedBox(
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Are you sure you want to permanently delete '
                            'this task?',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'CANCEL',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: onDelete,
                                child: const Text(
                                  'DELETE',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
            break;
          default:
        }
      },
    );
  }
}

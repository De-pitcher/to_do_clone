import 'package:flutter/material.dart';

import '../../enums/planned_menu_value.dart';
import '../../utils/constants/constants.dart';

class PlannedPopupMenu extends StatelessWidget {
  final String title;
  final Color color;
  final Function(PlannedMenuValue)? onSelected;
  const PlannedPopupMenu({
    super.key,
    required this.color,
    this.onSelected,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: PopupMenuButton(
        itemBuilder: (ctx) => plannedPopMenuEntries(ctx),
        position: PopupMenuPosition.under,
        onSelected: onSelected,
        child: Card(
          color: Colors.white30,
          child: SizedBox(
            height: 40,
            child: TextButton.icon(
              icon: Icon(Icons.menu, color: color),
              onPressed: null,
              label: Text(
                title,
                style: TextStyle(color: color),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

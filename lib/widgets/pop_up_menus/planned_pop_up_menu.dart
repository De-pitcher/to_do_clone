import 'package:flutter/material.dart';

import '../../enums/planned_menu_value.dart';
import '../../utils/constants/pop_menu_items.dart';

class PlannedPopupMenu extends StatefulWidget {
  final Color color;
  const PlannedPopupMenu({
    super.key,
    required this.color,
  });

  @override
  State<PlannedPopupMenu> createState() => _PlannedPopupMenuState();
}

class _PlannedPopupMenuState extends State<PlannedPopupMenu> {
  var _plannedPopUpVal = 'All planned';

  void changePopupTitle(String value) {
    setState(() {
      _plannedPopUpVal = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: PopupMenuButton(
        itemBuilder: (ctx) => plannedPopMenuEntries(ctx),
        position: PopupMenuPosition.under,
        onSelected: (value) {
          switch (value) {
            case PlannedMenuValue.overDue:
              changePopupTitle('Overdue');
              break;
            case PlannedMenuValue.today:
              changePopupTitle('Today');
              break;
            case PlannedMenuValue.tomorrow:
              changePopupTitle('Tomorrow');
              break;
            case PlannedMenuValue.thisWeek:
              changePopupTitle('This week');
              break;
            case PlannedMenuValue.later:
              changePopupTitle('Later');
              break;
            default:
              changePopupTitle('All planned');
          }
        },
        child: Card(
          color: Colors.white30,
          child: SizedBox(
            height: 40,
            child: TextButton.icon(
              icon: Icon(Icons.menu, color: widget.color),
              onPressed: null,
              label: Text(
                _plannedPopUpVal,
                style: TextStyle(color: widget.color),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

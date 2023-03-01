import 'package:flutter/material.dart';

import '../../enums/enums.dart';

List<PopupMenuEntry<SelectPopMenuValue>> selectPopMenuEntries(
  BuildContext context,
  bool displayMarkAsImport,
  bool clearAll,
) =>
    [
      clearAll
          ? const PopupMenuItem(
              value: SelectPopMenuValue.clearAll,
              child: Text('Clear all                       '),
            )
          : const PopupMenuItem(
              value: SelectPopMenuValue.selectAll,
              child: Text('Select all                       '),
            ),
      if (!displayMarkAsImport)
        const PopupMenuItem(
          value: SelectPopMenuValue.markAsImportant,
          child: Text('Mark as important'),
        ),
      const PopupMenuItem(
        value: SelectPopMenuValue.move,
        child: Text('Move'),
      ),
      const PopupMenuItem(
        value: SelectPopMenuValue.copy,
        child: Text('Copy'),
      ),
      const PopupMenuItem(
        value: SelectPopMenuValue.deleteTask,
        child: Text('Delete task'),
      ),
    ];

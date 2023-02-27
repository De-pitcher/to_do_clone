import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final Function()? onDelete;
  const ConfirmDeleteDialog({super.key, this.onDelete});

  @override
  Widget build(BuildContext context) {
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
  }
}

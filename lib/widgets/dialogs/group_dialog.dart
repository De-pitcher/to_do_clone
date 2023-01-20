import 'package:flutter/material.dart';

class GroupDialog extends StatefulWidget {
  const GroupDialog({super.key});

  @override
  State<GroupDialog> createState() => _GroupDialogState();
}

class _GroupDialogState extends State<GroupDialog> {
  String _groupTitle = '';
  var _isButtonEnabled = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 120,
      child: Column(
        children: [
          TextField(
            autofocus: true,
            decoration: const InputDecoration(enabled: true),
            onChanged: (value) {
              _groupTitle = value;
              setState(() {
                _isButtonEnabled = value.isNotEmpty;
              });
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: !_isButtonEnabled ? null : () {},
                child: Text(
                  'CREATE GROUP',
                  style: TextStyle(
                    color: !_isButtonEnabled ? Colors.grey : Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

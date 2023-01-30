import 'package:flutter/material.dart';


class GroupDialog extends StatefulWidget {
  final Function(String)? onCreatePressed;
  final String? actionButtonTitle;
  final String? initialFieldValue;
  const GroupDialog({
    super.key,
    this.onCreatePressed,
    this.initialFieldValue,
    this.actionButtonTitle = 'CREATE GROUP',
  });

  @override
  State<GroupDialog> createState() => _GroupDialogState();
}

class _GroupDialogState extends State<GroupDialog> {
  String _groupTitle = '';
  var _isButtonEnabled = false;

  void onSaveFn(String value) {
    _groupTitle = value;
    setState(() {
      _isButtonEnabled = value.isNotEmpty;
    });
  }

  void onPressed(String value) {
    widget.onCreatePressed!(value);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 120,
      child: Column(
        children: [
          TextFormField(
            initialValue: widget.initialFieldValue ?? '',
            autofocus: true,
            decoration: const InputDecoration(enabled: true),
            onChanged: onSaveFn,
            onFieldSubmitted: onPressed,
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
                onPressed:
                    !_isButtonEnabled ? null : () => onPressed(_groupTitle),
                child: Text(
                  widget.actionButtonTitle!,
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

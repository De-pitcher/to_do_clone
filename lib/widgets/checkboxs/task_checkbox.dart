import 'package:flutter/material.dart';

class TaskCheckbox extends StatelessWidget {
  final Color color;
  final bool value;
  final bool isRounded;
  final Function(bool?)? onChanged;
  const TaskCheckbox({
    Key? key,
    required this.color,
    required this.onChanged,
    required this.value,
    this.isRounded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      shape: isRounded
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      splashRadius: 35,
      activeColor: color,
      checkColor: Colors.black,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onChanged: onChanged,
    );
  }
}

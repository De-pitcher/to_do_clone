import 'package:flutter/material.dart';

import '../models/activity.dart';
import 'list_widget.dart';

class ListTileWidget extends StatelessWidget {
  final Activity activity;
  final bool showTrailingIcon;
  final bool? isSelected;
  final Function()? onIconPressed;
  const ListTileWidget({
    Key? key,
    required this.activity,
    required this.showTrailingIcon,
    this.isSelected = false,
    this.onIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(activity.id.toString()),
      leading: const Icon(Icons.list),
      title: Text(activity.title),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ListWidget(
              key: Key(activity.id.toString()),
              title: activity.title,
              bgColor: activity.color,
              image: activity.image,
              fileImage: activity.fileImage,
            ),
          ),
        );
      },
      trailing: showTrailingIcon
          ? isSelected!
              ? GestureDetector(
                  onTap: onIconPressed!(),
                  child: const Icon(
                    Icons.check,
                    color: Colors.blue,
                  ),
                )
              : GestureDetector(
                  onTap: onIconPressed,
                  child: const Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                )
          : null,
    );
  }
}

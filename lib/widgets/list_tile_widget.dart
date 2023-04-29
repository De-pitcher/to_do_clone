import 'package:flutter/material.dart';

import '../models/activity.dart';
import '../utils/res/theme.dart';
import 'list_widget.dart';

class ListTileWidget extends StatelessWidget {
  final Activity activity;
  const ListTileWidget(this.activity, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(activity.id.toString()),
      leading: Icon(
        Icons.list,
        color: activity.color,
      ),
      title: Text(activity.title),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ListWidget(
              key: Key(activity.id.toString()),
              title: activity.title,
              color: activity.color,
              image: activity.image,
              fileImage: activity.fileImage,
            ),
          ),
        );
      },
      trailing: Text(
        activity.tasks.isEmpty ? '' : '${activity.tasks.length}',
        style: ThemeMode.system == ThemeMode.light
            ? AppTheme.lightTheme.textTheme.bodySmall!
                .copyWith(color: Colors.grey)
            : AppTheme.darkTheme.textTheme.bodySmall!
                .copyWith(color: Colors.grey),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../models/activity.dart';
import './list_widget.dart';

class ListTileWidget extends StatelessWidget {
  final Activity activity;
  const ListTileWidget({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(activity.key.toString()),
      leading: const Icon(Icons.list),
      title: Text(activity.title),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ListWidget(
              key: Key(activity.key.toString()),
              title: activity.title,
              bgColor: activity.color,
              image: activity.image,
              fileImage: activity.fileImage,
            ),
          ),
        );
      },
    );
  }
}

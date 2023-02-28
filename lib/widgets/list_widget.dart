import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/constants/pop_menu_items.dart';

class ListWidget extends StatelessWidget {
  /// This is the title of the [ListWidget]
  final String title;

  /// This is the image of the [ListWidget] which can be null when
  /// not specified  but one of the both [image] or [fileImage]
  /// must be specified
  final String? image;

  /// This is the file image of the [ListWidget] which can be null
  /// when not specified but one of the both [image] or [fileImage]
  /// must be specified
  final File? fileImage;

  /// Background color of the [ListWidget] 
  final Color bgColor;

  /// A widget that holds the list of [TaskTile]s that contains
  /// lists of tasks
  const ListWidget({
    Key? key,
    required this.title,
    required this.bgColor,
    this.image,
    this.fileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: bgColor,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.person_add_alt,
            color: bgColor,
          ),
        ),
        PopupMenuButton(
          itemBuilder: (ctx) => popMenuEntries(ctx),
        )
      ],
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 48, 74),
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: image != null
              ? DecorationImage(
                  image: AssetImage(image!),
                  fit: BoxFit.cover,
                )
              : fileImage != null
                  ? DecorationImage(
                      image: FileImage(fileImage!),
                      fit: BoxFit.cover,
                    )
                  : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: appBar.preferredSize.height + 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: bgColor,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

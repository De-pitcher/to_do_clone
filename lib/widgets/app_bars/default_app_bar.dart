import 'package:flutter/material.dart';

AppBar defaultAppBar(BuildContext context, Color color) => AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 40,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        },
      ),
      iconTheme: IconThemeData(color: color),
      actionsIconTheme: IconThemeData(color: color),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );

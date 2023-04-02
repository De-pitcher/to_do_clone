import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/list_theme.dart';
import '../widgets/dialogs/list_dialog_content.dart';
import '../widgets/list_widget.dart';

class ListScreen extends StatefulWidget {
  static const id = '/list-screen';

  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() {
      Provider.of<ListTheme>(context, listen: false).resetListTitle();

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) {
            return AlertDialog(
              backgroundColor: Colors.black,
              title: const Text('New list'),
              titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
              content: const ListDialogContent(),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ListTheme>(context);
    return ListWidget(
      title: colorProvider.listTitle,
      fileImage: colorProvider.selectedFileImage,
      image: colorProvider.selectedImage,
      bgColor: colorProvider.selectedColor,
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/dialogs/list_dialog_content.dart';
import '../widgets/list_widget.dart';
import '../providers/app_color.dart';

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
    final colorProvider = Provider.of<AppColor>(context);
    return ListWidget(
      title: colorProvider.listTitle,
      fileImage: colorProvider.selectedFileImage,
      image: colorProvider.selectedImage,
      bgColor: colorProvider.selectedColor,
    );
  }
}

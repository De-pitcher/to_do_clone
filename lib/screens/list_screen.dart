import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants/pop_menu_items.dart';
import '../widgets/dialog_content.dart';
import '../providers/app_color.dart';

class ListScreen extends StatefulWidget {
  static const id = '/list-screen';

  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _listTitleController = TextEditingController();
  final String defaultTitle = 'Untitled list';
  @override
  void initState() {
    Timer.run(() {
      final colorsProvider = Provider.of<AppColor>(context, listen: false);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.black,
          title: const Text('New list'),
          titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
              ),
          content: DialogContent(
            TextField(
              controller: _listTitleController,
              decoration: InputDecoration(
                hintText: 'Enter list title',
                hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.grey,
                    ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: colorsProvider.listOfSelectedColors.isNotEmpty
                        ? colorsProvider.listOfSelectedColors.last
                        : colorsProvider.selectedColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: colorsProvider.listOfSelectedColors.isNotEmpty
                        ? colorsProvider.listOfSelectedColors.last
                        : colorsProvider.selectedColor,
                  ),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: colorsProvider.listOfSelectedColors.isNotEmpty
                        ? colorsProvider.listOfSelectedColors.last
                        : colorsProvider.selectedColor,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: colorsProvider.listOfSelectedColors.isNotEmpty
                        ? colorsProvider.listOfSelectedColors.last
                        : colorsProvider.selectedColor,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: _listTitleController.text.trim() == '' ? null : () {},
              child: Text(
                'CREATE LIST',
                style: TextStyle(
                  color: _listTitleController.text.trim() == ''
                      ? Colors.grey
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<AppColor>(context);
    final selectedImage = Provider.of<AppColor>(context).selectedImage;

    final selectedColor = colorProvider.listOfSelectedColors.isNotEmpty
        ? colorProvider.listOfSelectedColors.last
        : colorProvider.selectedColor;

    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: selectedColor,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.person_add_alt,
            color: selectedColor,
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
          image: selectedImage != null
              ? DecorationImage(
                  image: AssetImage(selectedImage),
                  fit: BoxFit.cover,
                )
              : colorProvider.fileImages.isNotEmpty &&
                      colorProvider.selectedFileImage != null
                  ? DecorationImage(
                      image: FileImage(colorProvider.selectedFileImage!),
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
                _listTitleController.text == ''
                    ? defaultTitle
                    : _listTitleController.text,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: selectedColor,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

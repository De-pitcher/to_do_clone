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
  @override
  void initState() {
    Timer.run(() {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.white12,
          title: const Text('New list'),
          titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
              ),
          content: const DialogContent(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<AppColor>(context);

    final selectedColor = colorProvider.listOfSelectedColors.isNotEmpty
        ? colorProvider.listOfSelectedColors.last
        : colorProvider.selectedColor;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: selectedColor,
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Untitled list',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: selectedColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

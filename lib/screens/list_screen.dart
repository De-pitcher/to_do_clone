import 'package:flutter/material.dart';

import '../widgets/menu_item.dart';

enum PopMenuValue {
  renameList,
  sortBy,
  addShortcut,
  changeTheme,
  sendCopy,
  duplicateList,
  printList,
  deleteList,
  turnOnSuggestion,
}

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<PopupMenuEntry<PopMenuValue>> popMenuEntries = [];

  @override
  void didChangeDependencies() {
    popMenuEntries = [
      PopupMenuItem(
        value: PopMenuValue.renameList,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.edit_outlined,
          text: 'Rename list',
        ),
      ),
      PopupMenuItem(
        value: PopMenuValue.sortBy,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.filter_list,
          text: 'Sort by',
        ),
      ),
      PopupMenuItem(
        value: PopMenuValue.addShortcut,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.shortcut,
          text: 'Add shortcut to homescreen',
        ),
      ),
      PopupMenuItem(
        value: PopMenuValue.changeTheme,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.settings_display_sharp,
          text: 'Change theme',
        ),
      ),
      PopupMenuItem(
        value: PopMenuValue.sendCopy,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.share,
          text: 'Send a copy',
        ),
      ),
      PopupMenuItem(
        value: PopMenuValue.duplicateList,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.copy,
          text: 'Duplicate list',
        ),
      ),
      PopupMenuItem(
        value: PopMenuValue.printList,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.print_outlined,
          text: 'Print list',
        ),
      ),
      PopupMenuItem(
        value: PopMenuValue.deleteList,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.delete_forever_outlined,
          text: 'Delete list',
        ),
      ),
      PopupMenuItem(
        value: PopMenuValue.turnOnSuggestion,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.lightbulb_outlined,
          text: 'Turn on suggestions',
        ),
      ),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_add_alt),
          ),
          PopupMenuButton(
            color: Colors.black,
            itemBuilder: (ctx) => popMenuEntries,
          )
        ],
      ),
    );
  }
}

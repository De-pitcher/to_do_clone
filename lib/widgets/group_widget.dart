import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:to_do_clone/widgets/list_widget.dart';

import '../models/activity.dart';
import '../providers/activities.dart';
import '../utils/constants/pop_menu_items.dart';

class GroupWidget extends StatefulWidget {
  final String name;
  final List<Activity> lists;
  const GroupWidget(this.name, this.lists, {super.key});

  @override
  State<GroupWidget> createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget>
    with SingleTickerProviderStateMixin {
  var _expanded = false;
  late final AnimationController _controller;
  late final Animation<double> _angleAnimation;
  late final Animation<double> _widthAnimation;
  late final Animation<double> _listIconOpacityAnimation;
  late final Animation<double> _popMenuIconOpacityAnimation;

  late List<Widget> _contents;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _listIconOpacityAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      // _controller
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    _popMenuIconOpacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      // _controller
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _angleAnimation = Tween<double>(
      begin: pi / 2,
      end: 0,
    ).animate(
      // _controller
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    _widthAnimation = Tween<double>(
      begin: 0,
      end: -48,
    ).animate(
      // _controller
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _controller.reset();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showList() {
    setState(() {
      if (!_expanded && _controller.isDismissed) {
        _controller.forward();
      } else if (_controller.isCompleted) {
        _controller.reverse();
      }
      _expanded = !_expanded;
    });
  }

  @override
  void didChangeDependencies() {
    _contents = widget.lists.map((e) {
      return Padding(
        key: UniqueKey(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            const SizedBox(
              height: 60,
              child: VerticalDivider(
                width: 5,
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: ListTile(
                leading: const Icon(Icons.list),
                title: Text(e.title),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ListWidget(
                        title: e.title,
                        bgColor: e.color,
                        image: e.image,
                        fileImage: e.fileImage,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }).toList();
    super.didChangeDependencies();
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      Widget row = _contents.removeAt(oldIndex);
      _contents.insert(newIndex, row);
    });
  }

  // _onItemReorder(
  //     int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
  //   setState(() {
  //     var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
  //     _contents[newListIndex].children.insert(newItemIndex, movedItem);
  //   });
  // }

  // _onListReorder(int oldListIndex, int newListIndex) {
  //   setState(() {
  //     var movedList = _contents.removeAt(oldListIndex);
  //     _contents.insert(newListIndex, movedList);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ReorderableColumn(
      header: ListTile(
        contentPadding: const EdgeInsets.only(left: 16.0),
        leading: AnimatedBuilder(
          animation: _controller,
          builder: (ctx, ch) => Opacity(
            opacity: _listIconOpacityAnimation.value,
            child: const Icon(Icons.task_outlined),
          ),
        ),
        title: AnimatedBuilder(
          animation: _controller,
          builder: (ctx, ch) => Transform.translate(
            offset: Offset(_widthAnimation.value, 0),
            child: Text(widget.name),
          ),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (ctx, ch) => Opacity(
                  opacity: _popMenuIconOpacityAnimation.value,
                  child: PopupMenuButton(
                    itemBuilder: (ctx) => groupPopMenuEntries(ctx),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (ctx, ch) => Transform.rotate(
                  angle: _angleAnimation.value,
                  child: IconButton(
                    onPressed: _showList,
                    icon: const Icon(Icons.expand_more),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onReorder: _onReorder,
      children: _expanded
          ? _contents.isEmpty
              ? [
                  Padding(
                    key: UniqueKey(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: const [
                        SizedBox(
                          height: 70,
                          child: VerticalDivider(
                            width: 5,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Tap and drag here to add lists',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                ]
              : _contents
          : [],
    );
    //   return InkWell(
    //     splashColor: Colors.grey,
    //     onTap: _showList,
    //     child: SizedBox(
    //       height: _expanded ? 200 : 60,
    //       child: Column(
    //         children: [
    //           ListTile(
    //             contentPadding: const EdgeInsets.only(left: 16.0),
    //             leading: AnimatedBuilder(
    //               animation: _controller,
    //               builder: (ctx, ch) => Opacity(
    //                 opacity: _listIconOpacityAnimation.value,
    //                 child: const Icon(Icons.task_outlined),
    //               ),
    //             ),
    //             title: AnimatedBuilder(
    //               animation: _controller,
    //               builder: (ctx, ch) => Transform.translate(
    //                 offset: Offset(_widthAnimation.value, 0),
    //                 child: Text(widget.name),
    //               ),
    //             ),
    //             trailing: SizedBox(
    //               width: 100,
    //               child: Row(
    //                 children: [
    //                   AnimatedBuilder(
    //                     animation: _controller,
    //                     builder: (ctx, ch) => Opacity(
    //                       opacity: _popMenuIconOpacityAnimation.value,
    //                       child: PopupMenuButton(
    //                         itemBuilder: (ctx) => groupPopMenuEntries(ctx),
    //                       ),
    //                     ),
    //                   ),
    //                   AnimatedBuilder(
    //                     animation: _controller,
    //                     builder: (ctx, ch) => Transform.rotate(
    //                       angle: _angleAnimation.value,
    //                       child: IconButton(
    //                         onPressed: _showList,
    //                         icon: const Icon(Icons.expand_more),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           if (_expanded)
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //               child: Row(
    //                 children: const [
    //                   SizedBox(
    //                     height: 70,
    //                     child: VerticalDivider(
    //                       width: 5,
    //                       thickness: 1,
    //                       color: Colors.grey,
    //                     ),
    //                   ),
    //                   Expanded(
    //                     child: Text(
    //                       'Tap and drag here to add lists',
    //                       textAlign: TextAlign.center,
    //                       style: TextStyle(color: Colors.grey),
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             )
    //         ],
    //       ),
    //     ),
    //   );
  }
}

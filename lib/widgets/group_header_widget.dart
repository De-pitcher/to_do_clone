import 'dart:math';

import 'package:flutter/material.dart';

import '../enums/group_pop_menu_value.dart';
import '../utils/constants/pop_menu_items.dart';

class GroupHeaderWidget extends StatefulWidget {
  final String name;
  final bool expanded;
  final bool isEmpty;
  final Function()? onHide;
  final Function(GroupPopMenuValue) onPopMenuItemSelected;
  const GroupHeaderWidget({
    required this.name,
    required this.expanded,
    required this.isEmpty,
    required this.onPopMenuItemSelected,
    this.onHide,
    super.key,
  });

  @override
  State<GroupHeaderWidget> createState() => _GroupHeaderWidgetState();
}

class _GroupHeaderWidgetState extends State<GroupHeaderWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _angleAnimation;
  late final Animation<double> _widthAnimation;
  late final Animation<double> _listIconOpacityAnimation;
  late final Animation<double> _popMenuIconOpacityAnimation;

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
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    _popMenuIconOpacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _angleAnimation = Tween<double>(
      begin: pi / 2,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    _widthAnimation = Tween<double>(
      begin: 0,
      end: -48,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _controller.reset();
    super.initState();
  }

  void _showList() {
    setState(() {
      if (!widget.expanded && _controller.isDismissed) {
        _controller.forward();
      } else if (_controller.isCompleted) {
        _controller.reverse();
      }
      widget.onHide!();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16.0),
      onTap: _showList,
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (ctx, ch) => Opacity(
                opacity: _popMenuIconOpacityAnimation.value,
                child: _popMenuIconOpacityAnimation.value == 0
                    ? null
                    : PopupMenuButton(
                        itemBuilder: (ctx) =>
                            groupPopMenuEntries(ctx, widget.isEmpty),
                        position: PopupMenuPosition.under,
                        onSelected: widget.onPopMenuItemSelected,
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
    );
  }
}

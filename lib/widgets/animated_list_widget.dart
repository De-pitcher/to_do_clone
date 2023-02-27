import 'package:flutter/material.dart';

import '../models/animated_list_model.dart';
import 'completed_task_header.dart';

class AnimatedListWidget extends StatefulWidget {
  final AnimatedListModel listModel;
  final bool? isExpanded;
  final bool displayHeaderWidget;
  final Color color;
  final Widget Function(BuildContext, int, Animation<double>) itemBuilder;
  final Function(bool)? onHide;
  const AnimatedListWidget({
    super.key,
    required this.listModel,
    this.isExpanded = true,
    required this.color,
    required this.itemBuilder,
    this.onHide,
    required this.displayHeaderWidget,
  });

  @override
  State<AnimatedListWidget> createState() => _AnimatedListWidgetState();
}

class _AnimatedListWidgetState extends State<AnimatedListWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.listModel.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                CompletedTaskHeader(
                  numCompleted: widget.listModel.length,
                  color: widget.color,
                  onHide: widget.onHide,
                ),
                if (widget.isExpanded!)
                  AnimatedOpacity(
                    opacity: widget.isExpanded! ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      height: widget.listModel.length * 70,
                      child: AnimatedList(
                        key: widget.listModel.listKey,
                        initialItemCount: widget.listModel.length,
                        itemBuilder: widget.itemBuilder,
                      ),
                    ),
                  ),
              ],
            ),
          );
  }
}

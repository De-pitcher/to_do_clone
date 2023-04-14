import 'package:flutter/material.dart';

import '../models/animated_list_model.dart';
import './completed_task_header.dart';

/// This widget [AnimatedListWidget] creates a customized [AnimatedList].
class AnimatedListWidget extends StatefulWidget {
  /// Contains meta-data about the lists of tasks.
  final AnimatedListModel listModel;

  /// This controlls the animation of [CompletedTaskHeader] widget.
  /// And incase it is not desired it is nullable [Null] and initialy
  /// assigned to be true in other for the list to be displayed.
  final bool? isExpanded;

  /// This checks if a [CompletedTaskHeader] should be displayed or not.
  final bool displayHeaderWidget;

  /// This [headerWidget] is displayed when [displayHeaderWidget] is
  /// set to null
  final Widget? headerWidget;

  /// This is the color of the widget in the [CompletedTaskHeader].
  final Color color;

  /// This function [itemBuilder] builds and handles the animation of
  /// an item in the [AnimatedListWidget]
  final Widget Function(BuildContext, int, Animation<double>) itemBuilder;

  /// This function [onHide] handles the animation of the
  /// [CompletedTaskHeader]
  final Function(bool)? onHide;

  /// This widget [AnimatedListWidget] creates a customized [AnimatedList].
  /// This widget gives the capability of creating a [CompletedTaskHeader]
  /// which is animated and it can be controlled using the [isExpanded]
  /// variable.
  ///
  /// It accepts [AnimatedListModel] and a widget [itemBuilder] to display
  /// the list
  const AnimatedListWidget({
    super.key,
    required this.listModel,
    this.isExpanded = true,
    required this.color,
    required this.itemBuilder,
    this.onHide,
    required this.displayHeaderWidget,
    this.headerWidget,
  });

  @override
  State<AnimatedListWidget> createState() => _AnimatedListWidgetState();
}

class _AnimatedListWidgetState extends State<AnimatedListWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.listModel.isEmpty && widget.headerWidget == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                if (widget.displayHeaderWidget)
                  CompletedTaskHeader(
                    numCompleted: widget.listModel.length,
                    color: widget.color,
                    onHide: widget.onHide,
                  )
                else
                  widget.headerWidget ?? Container(),
                if (widget.isExpanded! && !widget.listModel.isEmpty)
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

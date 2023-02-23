import 'package:flutter/material.dart';

class CompletedTaskHeader extends StatefulWidget {
  final int numCompleted;
  final Function(bool)? onHide;
  final Color color;
  const CompletedTaskHeader(
      {super.key,
      this.onHide,
      required this.numCompleted,
      required this.color});

  @override
  State<CompletedTaskHeader> createState() => _CompletedTaskHeaderState();
}

class _CompletedTaskHeaderState extends State<CompletedTaskHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  //* handles the animation of the name(title of the group widget)
  late final Animation<double> _angleAnimation;
  var isExpanded = false;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _angleAnimation = Tween<double>(
      begin: 0,
      end: -1.5,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    super.initState();
  }

  /// Toggles the [isExpanded] variable
  void toggleIsExpanded() {
    isExpanded = !isExpanded;
  }

  /// Animates the [GroupHeaderWidget] forward and backwards
  void _showList(bool expanded) {
    setState(() {
      if (!expanded && _controller.isDismissed) {
        _controller.forward();
      } else if (_controller.isCompleted) {
        _controller.reverse();
      }
      if (widget.onHide != null) {
        widget.onHide!(expanded);
      }
    });
    toggleIsExpanded();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AnimatedBuilder(
        animation: _controller,
        builder: (ctx, ch) => Transform.rotate(
          angle: _angleAnimation.value,
          child: IconButton(
            onPressed: () => _showList(isExpanded),
            icon: Icon(
              Icons.expand_more,
              color: widget.color,
            ),
          ),
        ),
      ),
      horizontalTitleGap: 0,
      title: Text(
        'Completed ${widget.numCompleted}',
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: widget.color),
      ),
    );
  }
}

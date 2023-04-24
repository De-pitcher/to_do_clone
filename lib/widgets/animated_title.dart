import 'package:flutter/material.dart';

class AnimatedTitle extends StatefulWidget {
  final String title;
  final String? subtitle;
  final Color? titleColor;
  final bool driveAnimation;
  final bool displaySubtitle;
  const AnimatedTitle({
    Key? key,
    required this.driveAnimation,
    required this.title,
    this.subtitle,
    required this.displaySubtitle,
    this.titleColor,
  }) : super(key: key);

  @override
  State<AnimatedTitle> createState() => _AnimatedTitleState();
}

class _AnimatedTitleState extends State<AnimatedTitle>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _position;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    setState(() {
      _position = Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: widget.displaySubtitle
            ? const Offset(
                0.0,
                -1,
              )
            : const Offset(
                0.0,
                -1.5,
              ),
      ).animate(
        CurvedAnimation(curve: Curves.ease, parent: _controller),
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (widget.driveAnimation) _controller.forward();
    });
    return SlideTransition(
      position: _position,
      child: widget.displaySubtitle
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnimatedDefaultTextStyle(
                  style: _controller.status == AnimationStatus.dismissed
                      ? Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.white,
                          )
                      : Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                          ),
                  duration: const Duration(milliseconds: 300),
                  child: Text(widget.title),
                ),
                AnimatedDefaultTextStyle(
                  style: _controller.status == AnimationStatus.dismissed
                      ? Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                          )
                      : Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                          ),
                  duration: const Duration(milliseconds: 300),
                  child: Text(widget.subtitle!),
                )
              ],
            )
          : AnimatedDefaultTextStyle(
              style: _controller.status == AnimationStatus.dismissed
                  ? Theme.of(context).textTheme.headline4!.copyWith(
                        color: widget.titleColor ?? Colors.white,
                      )
                  : Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: widget.titleColor ?? Colors.white,
                      ),
              duration: const Duration(milliseconds: 300),
              child: Text(widget.title),
            ),
    );
  }
}

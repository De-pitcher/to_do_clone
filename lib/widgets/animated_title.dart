import 'package:flutter/material.dart';

class AnimatedTitle extends StatefulWidget {
  final bool driveAnimation;
  const AnimatedTitle({
    Key? key,
    required this.driveAnimation,
  }) : super(key: key);

  @override
  State<AnimatedTitle> createState() => _AnimatedTitleState();
}

class _AnimatedTitleState extends State<AnimatedTitle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Future myFuture;
  late final Animation<Offset> position;

  Future myAnimation() async {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    setState(() {
      position = Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: const Offset(0.1, -0.05),
      ).animate(CurvedAnimation(curve: Curves.ease, parent: _controller));
    });
  }

  @override
  void initState() {
    super.initState();
    myFuture = myAnimation();
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
      position: position,
      child: Column(
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
            child: const Text('My Day'),
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
            child: const Text('Saturday, February 11'),
          ),
        ],
      ),
    );
  }
}

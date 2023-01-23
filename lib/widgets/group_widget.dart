import 'package:flutter/material.dart';

import '../utils/constants/pop_menu_items.dart';

class GroupWidget extends StatefulWidget {
  final String name;
  const GroupWidget(this.name, {super.key});

  @override
  State<GroupWidget> createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
      child: _expanded
          ? SizedBox(
              height: 200,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 16.0),
                    title: Text(widget.name),
                    trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            PopupMenuButton(
                              itemBuilder: (ctx) => groupPopMenuEntries(ctx),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _expanded = !_expanded;
                                });
                              },
                              icon: const Icon(Icons.expand_more),
                            )
                          ],
                        )),
                  ),
                  Padding(
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
                  )
                ],
              ),
            )
          : ListTile(
              leading: const Icon(Icons.task_outlined),
              title: Text(widget.name),
              trailing: const Icon(
                Icons.arrow_back_ios_new,
                size: 15,
              ),
            ),
    );

    // return InkWell(
    //   onTap: () {
    //     setState(() {
    //       _expanded = !_expanded;
    //     });
    //     if (_expanded) {
    //       _controller.reverse();
    //     } else {
    //       _controller.forward();
    //     }
    //   },
    //   child: Column(
    //     children: [
    //       SizedBox(
    //         height: 50,
    //         child: Row(
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.only(left: 16.0),
    //               child: Row(
    //                 children: [
    //                   if (!_expanded) const Icon(Icons.task_outlined),
    //                   if (!_expanded) const SizedBox(width: 16.0),
    //                   SlideTransition(
    //                     position: _offsetAnimation,
    //                     child: Text(widget.name),
    //                   )
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    //   return InkWell(
    //     splashColor: Colors.grey,
    //     onTap: () {
    //       setState(() {
    //         _expanded = !_expanded;
    //       });
    //     },
    //     child: AnimatedCrossFade(
    //       firstChild: ListTile(
    //         leading: const Icon(Icons.task_outlined),
    //         title: Text(widget.name),
    //         trailing: const Icon(
    //           Icons.arrow_back_ios_new,
    //           size: 15,
    //         ),
    //       ),
    //       secondChild: SizedBox(
    //         height: 100,
    //         child: Column(
    //           children: [
    //             ListTile(
    //               contentPadding: const EdgeInsets.only(left: 16.0),
    //               title: Text(widget.name),
    //               trailing: SizedBox(
    //                   width: 100,
    //                   child: Row(
    //                     children: [
    //                       PopupMenuButton(
    //                         itemBuilder: (ctx) => groupPopMenuEntries(ctx),
    //                       ),
    //                       IconButton(
    //                         onPressed: () {
    //                           setState(() {
    //                             _expanded = !_expanded;
    //                           });
    //                         },
    //                         icon: const Icon(Icons.expand_more),
    //                       )
    //                     ],
    //                   )),
    //             )
    //           ],
    //         ),
    //       ),
    //       crossFadeState:
    //           _expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    //       duration: const Duration(milliseconds: 300),
    //     ),
    //   );
  }
}

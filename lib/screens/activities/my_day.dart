import 'package:flutter/material.dart';

import '../../widgets/animated_title.dart';

class MyDay extends StatefulWidget {
  static const String id = '/my_day';
  const MyDay({super.key});

  @override
  State<MyDay> createState() => _MyDayState();
}

class _MyDayState extends State<MyDay> {
  var _liftTitle = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        toolbarHeight: 40,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/my_day.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: AnimatedTitle(
              driveAnimation: _liftTitle,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              heroTag: UniqueKey(),
              elevation: 5,
              onPressed: () {},
              label: Row(
                children: const [
                  Icon(Icons.lightbulb_outline_sharp),
                  SizedBox(width: 10),
                  Text('Suggestion'),
                ],
              ),
            ),
            const SizedBox(width: 50),
            FloatingActionButton(
              heroTag: UniqueKey(),
              elevation: 5,
              onPressed: () {
                setState(() {
                  _liftTitle = true;
                });
              },
              child: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}

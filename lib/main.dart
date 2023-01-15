import 'package:flutter/material.dart';

import './widgets/dialog_content.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
      ),
      home: const MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              backgroundColor: Colors.black,
              title: const Text('New list'),
              titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
              content: DialogContent(),
            ),
          );
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (_) => const ListScreen(),
          //   ),
          // );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: const [
          Text('data'),
        ],
      ),
    );
  }
}

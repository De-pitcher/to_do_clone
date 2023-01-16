import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/list_screen.dart';
import './providers/app_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppColor>(
          create: (_) => AppColor(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
        ),
        home: const MyHome(),
      ),
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const ListScreen(),
            ),
          );
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

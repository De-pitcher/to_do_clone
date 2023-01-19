import 'package:flutter/material.dart';
import 'package:to_do_clone/models/task.dart';
import 'package:to_do_clone/widgets/task_tile.dart';

class Tasks extends StatefulWidget {
  final Color? color;
  static const String id = '/tasks';
  const Tasks({super.key, this.color});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 20,
      ),
      body: SafeArea(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Container();
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 2,
                  color: Colors.white24,
                );
              },
              itemCount: 10)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTask(context);
        },
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }

  Future<dynamic> addTask(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.black12,
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 2),
        builder: (context) {
          // MediaQuery.of(context).removeViewInsets(removeBottom: true);
          return Column(
            children: [
              TextField(
                cursorHeight: 24,
                decoration: InputDecoration(
                  hintText: 'Add a task',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 14, color: Colors.brown),
                  border:
                      const UnderlineInputBorder(borderSide: BorderSide.none),
                  prefixIcon: Icon(
                    Icons.circle_outlined,
                    size: 32,
                    color: Colors.brown,
                  ),
                  suffixIcon: GestureDetector(
                    child: Icon(
                      Icons.file_upload_outlined,
                      color: Colors.brown,
                      size: 32,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_month_rounded),
                    label: const Text('Set due date'),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_outlined),
                    label: const Text('Remind me'),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.repeat),
                    label: const Text('Repeat'),
                  )
                ],
              )
            ],
          );
        });
  }
}

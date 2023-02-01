import 'package:flutter/material.dart';

class StepTile extends StatelessWidget {
  final String step;
  const StepTile({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        child: Icon(Icons.circle_outlined),
      ),
      title: Text(
        step,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: Colors.white60),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.more_vert),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../widgets/new_list_theme_card.dart';
import '../widgets/circular_color_card.dart';

class DialogContent extends StatefulWidget {
  const DialogContent({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  Map<String, dynamic> colors = {
    'blue': Colors.blue,
    'pruple': Colors.purple,
    'pink': Colors.pink,
    'orange': Colors.orange,
    'green': Colors.green,
    'teal': Colors.teal,
    'grey': Colors.grey,
    'custom-blue': [
      Colors.blue,
      Colors.lightBlue[100],
    ],
    'custom-pruple': [
      Colors.purple,
      Colors.purpleAccent[100],
    ],
    'custom-pink': [
      Colors.pink,
      Colors.pinkAccent[100],
    ],
    'custom-orange': [
      Colors.orange,
      Colors.orangeAccent[100],
    ],
    'custom-green': [
      Colors.green,
      Colors.greenAccent[100],
    ],
    'custom-teal': [
      Colors.teal,
      Colors.tealAccent[100],
    ],
    'custom-grey': [
      Colors.grey,
      Colors.white,
    ],
  };
  @override
  Widget build(BuildContext context) {
    print(colors.length);
    return SizedBox(
      width: 600,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.face_retouching_natural,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter list title',
                    hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.grey,
                        ),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    disabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              NewListThemeCard(
                color: Colors.blue,
                isEnabled: true,
                text: 'Color',
              ),
              NewListThemeCard(
                color: Colors.blue,
                isEnabled: false,
                text: 'Photo',
              ),
              NewListThemeCard(
                color: Colors.blue,
                isEnabled: false,
                text: 'Custom',
              ),
              SizedBox(
                width: 70,
              ),
            ],
          ),
          SizedBox(
            height: 35,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: colors.entries.map<CircularColorCard>((e) {
                final color =
                    !e.key.toString().startsWith('c') ? e.value as Color : null;
                final listOfColor = e.key.toString().startsWith('c')
                    ? e.value as List<Color?>
                    : null;
                return CircularColorCard(
                  color: color,
                  listOfColor: listOfColor,
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

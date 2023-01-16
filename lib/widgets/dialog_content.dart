import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/new_list_theme_card.dart';
import '../widgets/circular_color_card.dart';
import '../providers/app_color.dart';

class DialogContent extends StatelessWidget {
  const DialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    // print(colors.length);
    final colorsProvider = Provider.of<AppColor>(context);
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
                icon: Icon(
                  Icons.face_retouching_natural,
                  color: colorsProvider.listOfSelectedColors.isNotEmpty
                      ? colorsProvider.listOfSelectedColors.last
                      : colorsProvider.selectedColor,
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
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: colorsProvider.listOfSelectedColors.isNotEmpty
                            ? colorsProvider.listOfSelectedColors.last
                            : colorsProvider.selectedColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: colorsProvider.listOfSelectedColors.isNotEmpty
                            ? colorsProvider.listOfSelectedColors.last
                            : colorsProvider.selectedColor,
                      ),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: colorsProvider.listOfSelectedColors.isNotEmpty
                            ? colorsProvider.listOfSelectedColors.last
                            : colorsProvider.selectedColor,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: colorsProvider.listOfSelectedColors.isNotEmpty
                            ? colorsProvider.listOfSelectedColors.last
                            : colorsProvider.selectedColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NewListThemeCard(
                color: colorsProvider.selectedColor,
                isEnabled: true,
                text: 'Color',
              ),
              NewListThemeCard(
                color: colorsProvider.listOfSelectedColors.isNotEmpty
                    ? colorsProvider.listOfSelectedColors.last
                    : colorsProvider.selectedColor,
                isEnabled: false,
                text: 'Photo',
              ),
              NewListThemeCard(
                color: colorsProvider.listOfSelectedColors.isNotEmpty
                    ? colorsProvider.listOfSelectedColors.last
                    : colorsProvider.selectedColor,
                isEnabled: false,
                text: 'Custom',
              ),
              const SizedBox(
                width: 70,
              ),
            ],
          ),
          SizedBox(
            height: 35,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: colorsProvider.colors.length,
              itemBuilder: (ctx, i) => CircularColorCard(
                key: ValueKey(colorsProvider.colors[i].id),
                color: colorsProvider.colors[i].color,
                listOfColor: colorsProvider.colors[i].listOfColors,
                isSelected: colorsProvider.colors[i].isSelected,
                onTap: () {
                  Provider.of<AppColor>(context, listen: false)
                      .selectCurrentColor(colorsProvider.colors[i]);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

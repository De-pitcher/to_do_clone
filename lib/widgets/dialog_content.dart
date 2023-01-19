import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './new_list_theme_card.dart';
import './circular_color_card.dart';
import './circular_image_card.dart';
import './picker.dart';
import '../providers/app_color.dart';
import '../enums/new_list_theme_value.dart';

class DialogContent extends StatefulWidget {
  final TextField textField;
  const DialogContent(this.textField,{super.key});

  @override
  State<DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  var _color = true;
  var _photo = false;
  var _custom = false;

  @override
  Widget build(BuildContext context) {
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
                child: widget.textField,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NewListThemeCard(
                color: colorsProvider.selectedColor,
                isEnabled: _color,
                text: 'Color',
                onPressed: () {
                  setState(() {
                    colorsProvider
                        .changeNewListThemeValue(NewListThemeValue.color);
                    _color = true;
                    _photo = false;
                    _custom = false;
                  });
                },
              ),
              NewListThemeCard(
                color: colorsProvider.listOfSelectedColors.isNotEmpty
                    ? colorsProvider.listOfSelectedColors.last
                    : colorsProvider.selectedColor,
                isEnabled: _photo,
                text: 'Photo',
                onPressed: () {
                  setState(() {
                    colorsProvider
                        .changeNewListThemeValue(NewListThemeValue.photo);
                    _photo = true;
                    _color = false;
                    _custom = false;
                  });
                },
              ),
              NewListThemeCard(
                color: colorsProvider.listOfSelectedColors.isNotEmpty
                    ? colorsProvider.listOfSelectedColors.last
                    : colorsProvider.selectedColor,
                isEnabled: _custom,
                text: 'Custom',
                onPressed: () {
                  setState(() {
                    colorsProvider
                        .changeNewListThemeValue(NewListThemeValue.custom);
                    _custom = true;
                    _color = false;
                    _photo = false;
                  });
                },
              ),
              const SizedBox(width: 70),
            ],
          ),
          SizedBox(
            height: 35,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: colorsProvider.newListThemeValue ==
                      NewListThemeValue.color
                  ? colorsProvider.colors.length
                  : colorsProvider.newListThemeValue == NewListThemeValue.photo
                      ? colorsProvider.images.length
                      : colorsProvider.fileImages.length + 1,
              itemBuilder: (ctx, i) {
                switch (colorsProvider.newListThemeValue) {
                  case NewListThemeValue.photo:
                    return CircularImageCard(
                      image: colorsProvider.images[i],
                      onTap: () {
                        colorsProvider.selectImage(i);
                      },
                      isPickedImage: false,
                    );
                  case NewListThemeValue.custom:
                    if (i == 0) {
                      return Picker(
                        colorsProvider.selectedColor,
                        (pickedFile) => colorsProvider.addFileImage(pickedFile),
                      );
                    }
                    return CircularImageCard(
                      fileImage: colorsProvider.fileImages[i - 1],
                      onTap: () {
                        colorsProvider.selectFileImage(i - 1);
                      },
                      isPickedImage: true,
                    );
                  default:
                    return CircularColorCard(
                      key: ValueKey(colorsProvider.colors[i].id),
                      color: colorsProvider.colors[i].color,
                      listOfColor: colorsProvider.colors[i].listOfColors,
                      isSelected: colorsProvider.colors[i].isSelected,
                      onTap: () {
                        Provider.of<AppColor>(context, listen: false)
                            .selectCurrentColor(colorsProvider.colors[i]);
                      },
                    );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

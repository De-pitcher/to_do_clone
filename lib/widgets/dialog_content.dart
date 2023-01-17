import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_clone/enums/new_list_theme_value.dart';

import './new_list_theme_card.dart';
import './circular_color_card.dart';
import './circular_image_card.dart';
import './picker.dart';
import '../providers/app_color.dart';

class DialogContent extends StatefulWidget {
  const DialogContent({super.key});

  @override
  State<DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  var _color = true;
  var _photo = false;
  var _custom = false;
  NewListThemeValue newListThemeValue = NewListThemeValue.color;

  File? _pickedImage;

  void _pickFile(File image) {
    _pickedImage = image;
  }

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
                isEnabled: _color,
                text: 'Color',
                onPressed: () {
                  setState(() {
                    newListThemeValue = NewListThemeValue.color;
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
                    newListThemeValue = NewListThemeValue.photo;
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
                    newListThemeValue = NewListThemeValue.custom;
                    _custom = true;
                    _color = false;
                    _photo = false;
                  });
                },
              ),
              const SizedBox(
                width: 70,
              ),
            ],
          ),
          SizedBox(
            height: 35,
            width: double.infinity,
            child:
                //  newListThemeValue == NewListThemeValue.custom
                //     ? ListView(
                //         children: [
                //           Picker(
                //             colorsProvider.selectedColor,
                //             (_) {},
                //           ),
                //           ...customImage
                //         ],
                //       )
                //     :
                ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newListThemeValue == NewListThemeValue.color
                  ? colorsProvider.colors.length
                  : newListThemeValue == NewListThemeValue.photo
                      ? colorsProvider.images.length
                      : 1,
              itemBuilder: (ctx, i) {
                // if (newListThemeValue == NewListThemeValue.photo) {

                // }

                switch (newListThemeValue) {
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
                        _pickFile,
                      );
                    }
                    return CircularImageCard(
                      fileImage: _pickedImage,
                      onTap: () {
                        colorsProvider.selectImage(i);
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

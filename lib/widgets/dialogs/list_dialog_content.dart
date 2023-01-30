import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/res/theme.dart';
import '../new_list_theme_card.dart';
import '../circular_color_card.dart';
import '../circular_image_card.dart';
import '../picker.dart';
import '../../providers/app_color.dart';
import '../../enums/new_list_theme_value.dart';
import '../../providers/activities.dart';

class ListDialogContent extends StatefulWidget {
  const ListDialogContent({super.key});

  @override
  State<ListDialogContent> createState() => _ListDialogContentState();
}

class _ListDialogContentState extends State<ListDialogContent> {
  var _color = true;
  var _photo = false;
  var _custom = false;
  var _isButtonEnabled = false;
  String _listTitle = '';

  void onSubmitted(AppColor colorsProvider) {
    colorsProvider.updateListTitle(_listTitle);
    final listProvider = Provider.of<Activities>(context, listen: false);
    listProvider.addListActivity(
      title: _listTitle,
      tasks: [],
      color: colorsProvider.selectedColor,
      image: colorsProvider.selectedImage,
      fileImage: colorsProvider.selectedFileImage,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final colorsProvider = Provider.of<AppColor>(context);
    return SizedBox(
      width: 600,
      height: 230,
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
              _textFieldBuild(context, colorsProvider),
            ],
          ),
          const SizedBox(height: 15),
          _newListThemeCardBuild(colorsProvider),
          const SizedBox(height: 10),
          _circularCardItemsBuild(colorsProvider, context),
          const SizedBox(height: 20),
          _actionButtonBuild(context, colorsProvider)
        ],
      ),
    );
  }

  Row _actionButtonBuild(BuildContext context, AppColor colorsProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: const Text(
            'CANCEL',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed:
              !_isButtonEnabled ? null : () => onSubmitted(colorsProvider),
          child: Text(
            'CREATE LIST',
            style: TextStyle(
              color: !_isButtonEnabled ? Colors.grey : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  SizedBox _circularCardItemsBuild(
      AppColor colorsProvider, BuildContext context) {
    return SizedBox(
      height: 35,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colorsProvider.newListThemeValue == NewListThemeValue.color
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
    );
  }

  Row _newListThemeCardBuild(AppColor colorsProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        NewListThemeCard(
          color: colorsProvider.selectedColor,
          isEnabled: _color,
          text: 'Color',
          onPressed: () {
            setState(() {
              colorsProvider.changeNewListThemeValue(NewListThemeValue.color);
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
              colorsProvider.changeNewListThemeValue(NewListThemeValue.photo);
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
              colorsProvider.changeNewListThemeValue(NewListThemeValue.custom);
              _custom = true;
              _color = false;
              _photo = false;
            });
          },
        ),
        const SizedBox(width: 70),
      ],
    );
  }

  Expanded _textFieldBuild(BuildContext context, AppColor colorsProvider) {
    return Expanded(
      child: TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Enter list title',
          hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.grey,
              ),
          border: AppTheme.underlineInputBorder(
            colorsProvider.listOfSelectedColors.isNotEmpty
                ? colorsProvider.listOfSelectedColors.last
                : colorsProvider.selectedColor,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: colorsProvider.listOfSelectedColors.isNotEmpty
                  ? colorsProvider.listOfSelectedColors.last
                  : colorsProvider.selectedColor,
            ),
          ),
          disabledBorder: AppTheme.underlineInputBorder(
            colorsProvider.listOfSelectedColors.isNotEmpty
                ? colorsProvider.listOfSelectedColors.last
                : colorsProvider.selectedColor,
          ),
          enabledBorder: AppTheme.underlineInputBorder(
            colorsProvider.listOfSelectedColors.isNotEmpty
                ? colorsProvider.listOfSelectedColors.last
                : colorsProvider.selectedColor,
          ),
        ),
        onChanged: (value) {
          _listTitle = value;
          setState(() {
            _isButtonEnabled = value.isNotEmpty;
          });
        },
        onSubmitted: (_) => onSubmitted(colorsProvider),
      ),
    );
  }
}

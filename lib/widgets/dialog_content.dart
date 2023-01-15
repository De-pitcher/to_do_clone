import 'package:flutter/material.dart';

import '../widgets/new_list_theme_card.dart';
import '../widgets/circular_color_card.dart';
import '../models/dialog_color_model.dart';

class DialogContent extends StatefulWidget {
  final Color? selcectedColor;
  final List<DialogColorModel> colors;
  const DialogContent({
    this.selcectedColor = Colors.blue,
    required this.colors,
    Key? key,
  }) : super(key: key);

  @override
  State<DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {
  Color _selectedColor = Colors.blue;
  var _selectedListOfColor = <Color?>[];
  @override
  Widget build(BuildContext context) {
    // print(colors.length);
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
                  color: _selectedListOfColor.isNotEmpty
                      ? _selectedListOfColor.last!
                      : _selectedColor,
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
                        color: _selectedListOfColor.isNotEmpty
                            ? _selectedListOfColor.last!
                            : _selectedColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: _selectedListOfColor.isNotEmpty
                            ? _selectedListOfColor.last!
                            : _selectedColor,
                      ),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: _selectedListOfColor.isNotEmpty
                            ? _selectedListOfColor.last!
                            : _selectedColor,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: _selectedListOfColor.isNotEmpty
                            ? _selectedListOfColor.last!
                            : _selectedColor,
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
                color: _selectedColor,
                isEnabled: true,
                text: 'Color',
              ),
              NewListThemeCard(
                color: _selectedListOfColor.isNotEmpty
                    ? _selectedListOfColor.last!
                    : _selectedColor,
                isEnabled: false,
                text: 'Photo',
              ),
              NewListThemeCard(
                color: _selectedListOfColor.isNotEmpty
                    ? _selectedListOfColor.last!
                    : _selectedColor,
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
              itemCount: widget.colors.length,
              itemBuilder: (ctx, i) => CircularColorCard(
                key: ValueKey(i),
                color: widget.colors[i].color,
                listOfColor: widget.colors[i].listOfColors,
                isSelected: widget.colors[i].isSelected,
                onTap: () {
                  setState(() {
                    for (var element in widget.colors) {
                      if (element == widget.colors[i]) {
                        widget.colors[i].isSelected =
                            !widget.colors[i].isSelected!;
                        _selectedColor = widget.colors[i].color != null
                            ? widget.colors[i].color!
                            : widget.colors[i].listOfColors.isNotEmpty
                                ? widget.colors[i].listOfColors.first!
                                : Colors.blue;
                        _selectedListOfColor =
                            widget.colors[i].listOfColors.isEmpty
                                ? []
                                : widget.colors[i].listOfColors;
                      } else {
                        element.isSelected = false;
                      }
                    }
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

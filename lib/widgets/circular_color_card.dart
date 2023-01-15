import 'package:flutter/material.dart';


class CircularColorCard extends StatelessWidget {
  final Color? color;
  final List<Color?>? listOfColor;
  final bool? isSelected;
  const CircularColorCard({
    this.color,
    this.listOfColor,
    this.isSelected = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: color == null && listOfColor == null
            ? Colors.grey
            : listOfColor != null
                ? listOfColor!.last
                : color,
        borderRadius: BorderRadius.circular(20),
        border: color == null && listOfColor == null
            ? null
            : listOfColor != null
                ? Border.all(
                    color: listOfColor!.first!,
                    width: 2,
                  )
                : null,
      ),
      child: isSelected!
          ? Center(
              child: Container(
                height: 20,
                width: 20,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
              ),
            )
          : null,
    );
  }
}

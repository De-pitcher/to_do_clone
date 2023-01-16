import 'package:flutter/material.dart';

class CircularColorCard extends StatelessWidget {
  final Color? color;
  final List<Color?> listOfColor;
  final bool isSelected;
  final Function()? onTap;
  const CircularColorCard({
    this.color,
    required this.listOfColor,
    this.isSelected = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // onTap: () => isSelected = !isSelected!,
      child: Container(
        width: 35,
        height: 35,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color == null && listOfColor.isEmpty
              ? Colors.grey
              : listOfColor.isNotEmpty
                  ? listOfColor.last
                  : color,
          borderRadius: BorderRadius.circular(20),
          border: color == null && listOfColor.isEmpty
              ? null
              : listOfColor.isNotEmpty
                  ? Border.all(
                      color: listOfColor.first!,
                      width: 2,
                    )
                  : null,
        ),
        child: isSelected
            ? Center(
                child: Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
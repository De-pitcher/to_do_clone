import 'dart:io';

import 'package:flutter/material.dart';

class CircularImageCard extends StatelessWidget {
  final String? image;
  final File? fileImage;
  final Function()? onTap;
  final bool isPickedImage;
  const CircularImageCard({
    super.key,
    this.image,
    this.fileImage,
    this.onTap,
    required this.isPickedImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 35,
        height: 35,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: isPickedImage
              ? DecorationImage(
                  image: FileImage(fileImage!),
                  fit: BoxFit.fill,
                )
              : DecorationImage(
                  image: AssetImage(image!),
                  fit: BoxFit.fill,
                ),
        ),
      ),
    );
  }
}

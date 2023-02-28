import 'package:flutter/material.dart';

  SnackBar snackbar({
    required Duration duration,
    required String msg,
    required ScaffoldMessengerState scaffoldMessenger,
    Function()? onPressed,
  }) {
    return SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      duration: duration,
      elevation: 0,
      backgroundColor: Colors.white24,
      content: SizedBox(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              msg,
              style: const TextStyle(color: Colors.white),
            ),
            TextButton(
              onPressed: onPressed,
              child: const Text('UNDO'),
            )
          ],
        ),
      ),
    );
  }
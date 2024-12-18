import 'package:flutter/material.dart';
import 'package:talk_line/core/style/app_colors.dart';

class CustomSnackBar {
  static void show(BuildContext context, {required String message, required bool isSuccess}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: isSuccess ? AppColors.secondaryColor : Colors.red,
      duration: const Duration(seconds: 3),
    );

    // Show the SnackBar using ScaffoldMessenger
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

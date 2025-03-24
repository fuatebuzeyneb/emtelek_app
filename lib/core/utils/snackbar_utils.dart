import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showSnackbar(BuildContext context, String message,
      [int seconds = 1]) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: AppColors.primary,
      duration: Duration(seconds: seconds),
      action: SnackBarAction(
        label: S.of(context).All,
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

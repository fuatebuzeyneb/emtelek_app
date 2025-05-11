import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onYes;
  final VoidCallback onNo;
  final Widget widget;

  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onYes,
    required this.onNo,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget,
          const SizedBox(height: 20),
          TextWidget(
            text: title,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          //   const SizedBox(height: 6),
          TextWidget(
            text: subtitle,
            fontSize: 16,
            color: Colors.grey,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonWidget(
                onTap: onYes,
                text: 'نعم',
                height: 0.04,
                width: 0.2,
                color: AppColors.primary,
                fontSize: 14,
                colorText: Colors.white,
              ),
              ButtonWidget(
                onTap: onNo,
                text: 'لا',
                height: 0.04,
                width: 0.2,
                color: Colors.black,
                fontSize: 14,
                colorText: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}

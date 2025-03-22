import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';

import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TabStyleButtonWidget extends StatelessWidget {
  const TabStyleButtonWidget(
      {super.key,
      this.height = 0.06,
      this.width = 0.3,
      required this.onTap,
      this.child,
      this.color = Colors.transparent,
      this.borderRadius = 8,
      this.text = 'Text',
      this.fontSize = 12,
      this.colorText = Colors.white,
      this.borderColor = Colors.transparent,
      this.bottomColor});

  final double height;
  final double width;
  final Function() onTap;
  final Color color;
  final Widget? child;
  final double borderRadius;
  final String? text;
  final double? fontSize;
  final Color? colorText;
  final Color borderColor;
  final Color? bottomColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Container(
            height: context.height * height,
            width: context.width * width,
            color: color,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: borderColor, width: 1),
                  right: BorderSide(color: borderColor, width: 1),
                  bottom: BorderSide(
                      color: bottomColor ?? borderColor,
                      width: bottomColor == null
                          ? 1
                          : 2), // حافة أسفل باللون الأسود
                  left: BorderSide(color: borderColor, width: 1),
                ),
              ),
              child: child ??
                  Center(
                    child: TextWidget(
                      text: text!,
                      color: colorText!,
                      fontSize: fontSize!,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
          ),
        ));
  }
}

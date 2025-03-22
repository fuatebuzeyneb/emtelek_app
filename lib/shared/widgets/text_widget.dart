import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.text,
      this.color = Colors.black,
      this.fontSize = 12,
      this.fontWeight,
      this.textAlign = TextAlign.center,
      this.isHaveOverflow = false,
      this.isHaveUnderline = false,
      this.fontFamily = 'Tajawal',
      this.maxLines});
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final bool isHaveOverflow;
  final bool isHaveUnderline;
  final String? fontFamily;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: getIt<CacheHelper>().getDataString(key: 'Lang') == 'tr'
            ? 'Jost'
            : fontFamily,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: isHaveUnderline == true ? TextDecoration.underline : null,
      ),
      textAlign: textAlign!,
      overflow: isHaveOverflow == true ? TextOverflow.ellipsis : null,
      maxLines: maxLines,
    );
  }
}

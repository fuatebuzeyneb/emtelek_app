import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ListTitleSection extends StatelessWidget {
  final String title;
  final String value;

  const ListTitleSection({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: title,
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                4.toHeight,
                TextWidget(
                  textAlign: TextAlign.start,
                  text: value,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
        8.toHeight,
        const Divider(height: 0),
        8.toHeight
      ],
    );
  }
}

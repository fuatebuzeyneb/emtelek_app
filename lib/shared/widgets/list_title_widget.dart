import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class LitsTitleWidget extends StatelessWidget {
  const LitsTitleWidget({
    super.key,
    this.color = Colors.black87,
    this.children,
    required this.image,
    required this.title,
    this.onTap,
    this.isHaveArrow = true,
  });

  final Color? color;
  final List<Widget>? children;
  final String image;
  final String title;
  final Function()? onTap;
  final bool isHaveArrow;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: ButtonWidget(
          height: 0.055,
          onTap: onTap ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    image,
                    height: 20,
                    width: 20,
                    color: color,
                  ),
                  const SizedBox(width: 12),
                  TextWidget(
                    text: title,
                    fontSize: 16,
                    color: color!,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              // القسم الأيمن
              Row(
                children: children ??
                    [
                      isHaveArrow == true
                          ? Icon(
                              Icons.arrow_forward_ios,
                              color: color,
                            )
                          : const SizedBox(),
                    ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}

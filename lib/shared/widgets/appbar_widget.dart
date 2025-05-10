import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? isHaveBackButton;
  final Widget? widget;
  final Function()? onTap;

  const AppBarWidget({
    super.key,
    required this.title,
    this.isHaveBackButton = false,
    this.widget,
    this.onTap,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      elevation: 1,
      shadowColor: Colors.black,
      backgroundColor: Color(0xFFF8FAFC),
      title: Row(
        children: [
          isHaveBackButton!
              ? getIt<CacheHelper>().getDataString(key: 'Lang') == 'ar'
                  ? Icon(Icons.arrow_back_ios)
                  : Icon(Icons.arrow_back_ios)
              : SizedBox(),
          isHaveBackButton! ? 8.toWidth : 0.toWidth,
          TextWidget(
            text: title,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          Spacer(),
          widget == null ? SizedBox() : widget!
        ],
      ),
      surfaceTintColor: Colors.transparent,
    );
  }
}

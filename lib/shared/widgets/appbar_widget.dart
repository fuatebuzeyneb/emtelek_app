import 'package:emtelek/core/extensions/media_query_extensions.dart';
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
      elevation: 1,
      shadowColor: Colors.black,
      backgroundColor: Color(0xFFF8FAFC),
      surfaceTintColor: Colors.transparent,
      title: Stack(
        alignment: Alignment.center,
        children: [
          if (isHaveBackButton!)
            Align(
              alignment: getIt<CacheHelper>().getDataString(key: 'Lang') == 'ar'
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: GestureDetector(
                onTap: onTap ??
                    () {
                      Navigator.pop(context);
                    },
                child: getIt<CacheHelper>().getDataString(key: 'Lang') != 'ar'
                    ? const Icon(Icons.arrow_forward_ios)
                    : const Icon(Icons.arrow_back_ios),
              ),
            ),
          Center(
            child: TextWidget(
              text: title,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (widget != null)
            Align(
              alignment: Alignment.centerRight,
              child: widget!,
            ),
        ],
      ),
    );
  }
}

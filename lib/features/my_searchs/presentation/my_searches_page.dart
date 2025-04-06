import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/widgets/appbar_widget.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class MySearchesPage extends StatelessWidget {
  const MySearchesPage({super.key});

  static const String id = "MySearchesPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 2,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: AppBarWidget(
          title: S.of(context).MySearches,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.appBarBackground,
      ),
      body: ButtonWidget(
        onTap: () {},
        color: Colors.white,
        height: 0.18,
        width: context.width * 1,
        borderRadius: 0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextWidget(
                    text: 'عقار ايجار' ' - ',
                    fontSize: 16,
                  ),
                  4.toWidth,
                  TextWidget(
                    text: 'شقه',
                    fontSize: 16,
                  ),
                  Spacer(),
                  Icon(Icons.more_vert_rounded)
                ],
              ),
              4.toHeight,
              TextWidget(
                text: 'عمليات البحث الخاصه بي',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              12.toHeight,
              Row(
                children: [
                  ButtonWidget(
                    paddingHorizontal: 12,
                    paddingVertical: 6,
                    borderRadius: 4,
                    height: 0,
                    width: 0,
                    onTap: () {},
                    text: 'دمشق',
                    color: Colors.grey,
                  ),
                  4.toWidth,
                  ButtonWidget(
                    paddingHorizontal: 12,
                    paddingVertical: 6,
                    borderRadius: 4,
                    height: 0,
                    width: 0,
                    onTap: () {},
                    text: 'حمص',
                    color: Colors.grey,
                  ),
                  4.toWidth,
                  ButtonWidget(
                    paddingHorizontal: 12,
                    paddingVertical: 6,
                    borderRadius: 4,
                    height: 0,
                    width: 0,
                    onTap: () {},
                    text: 'عدد الغرف 1,2,3,6',
                    color: Colors.grey,
                  )
                ],
              ),
              24.toHeight,
              TextWidget(
                text: 'تمام الحفظ بتاريخ 12/12/2022',
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

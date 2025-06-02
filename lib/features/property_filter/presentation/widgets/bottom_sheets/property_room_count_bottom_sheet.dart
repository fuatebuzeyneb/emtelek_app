import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:emtelek/features/property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/features/property_filter/domain/cubit/property_filter_cubit.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/features/auth/presentation/pages/login_page.dart';
import 'package:emtelek/features/auth/presentation/pages/signup_page.dart';
import 'package:emtelek/shared/widgets/bottom_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PropertyRoomCountBottomSheet extends StatelessWidget {
  const PropertyRoomCountBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PropertyFilterCubit propertyFilterCubit =
        BlocProvider.of<PropertyFilterCubit>(context);
    return BottomSheetWidget(
      circularRadius: 12,
      height: 0.3,
      widgetBody: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 4.0, vertical: 0.0), // EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5,
                  width: context.width * 0.13,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            24.toHeight,
            const Row(
              children: [
                TextWidget(
                  text: 'غرف النوم',
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                Spacer(),
                TextWidget(
                  text: 'اعادة الضبط',
                  fontSize: 14,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            8.toHeight,
            const TextWidget(
              text: 'اختر عدد غرف النوم',
              fontSize: 14,
              color: Colors.grey,
              // fontWeight: FontWeight.bold,
            ),
            24.toHeight,
            SizedBox(
              height: context.height * 0.04,
              width: context.width * 1,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: propertyFilterCubit.listRoomCount.contains(index)
                        ? ButtonWidget(
                            onTap: () {
                              propertyFilterCubit.removeListRoomCount(index);
                            },
                            color: Colors.white,
                            height: 0.025,
                            width: 0.15,
                            borderColor: AppColors.primary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.done,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: TextWidget(
                                    text: index == 11 ? '12+' : '${index + 1}',
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          )
                        : ButtonWidget(
                            onTap: () {
                              propertyFilterCubit.addListRoomCount(index);
                            },
                            color: Colors.white,
                            height: 0.025,
                            width: 0.085,
                            borderColor: Colors.black26,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: TextWidget(
                                    text: index == 11
                                        ? '12+'
                                        : (index + 1).toString(),
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                  );
                },
              ),
            ),
            const Spacer(),
            ButtonWidget(
                paddingHorizontal: 12,
                paddingVertical: 8,
                onTap: () {},
                text: 'اظهار النتائج',
                color: AppColors.primary,
                colorText: Colors.white,
                borderColor: AppColors.primary,
                borderRadius: 8,
                width: 1,
                height: 0.055),
            12.toHeight
          ],
        ),
      ),
    );
  }
}

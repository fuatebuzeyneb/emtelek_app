import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:emtelek/features/property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/features/property_filter/presentation/widgets/scroll_property_type_widget.dart';
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

class PropertyTypeBottomSheet extends StatelessWidget {
  const PropertyTypeBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    final propertyCubit = context.read<PropertyCubit>();
    return BottomSheetWidget(
      circularRadius: 12,
      height: 0.33,
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
            const TextWidget(
              text: 'نوع العقار',
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            8.toHeight,
            const TextWidget(
              text: 'اختر نوع العقار المطلوب',
              fontSize: 14,
              color: Colors.grey,
              // fontWeight: FontWeight.bold,
            ),
            24.toHeight,
            ScrollPropertyTypeWidget(itIsRent: propertyCubit.adType == 5),
            const Spacer(),
            ButtonWidget(
                paddingHorizontal: 12,
                paddingVertical: 8,
                onTap: () {
                  propertyCubit.applyFilter(
                    listCityIds: settingsCubit.selectedCityIds,
                    listDistrictIds: settingsCubit.selectedDistrictIds,
                    minPrice: settingsCubit.minPrice?.toInt(),
                    maxPrice: settingsCubit.maxPrice?.toInt(),
                    sortBy: settingsCubit.sortBy,
                  );
                  Navigator.pop(context);
                },
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

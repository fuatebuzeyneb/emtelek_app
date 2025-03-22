import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:emtelek/features/search_property/domain/property_cubit/property_cubit.dart';
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
    PropertyCubit propertyCubit = BlocProvider.of<PropertyCubit>(context);
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ButtonWidget(
                    onTap: () {
                      propertyCubit.changePropertyType(8);
                    },
                    color: Colors.white,
                    height: 0.085,
                    width: 0.2,
                    borderColor: propertyCubit.propertyType == 8
                        ? AppColors.primary
                        : Colors.black26,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/home.png',
                          height: 23,
                          width: 23,
                          color: propertyCubit.propertyType == 8
                              ? AppColors.primary
                              : Colors.black,
                        ),
                        4.toHeight,
                        TextWidget(
                          text: S.of(context).Apartment,
                          fontSize: 14,
                          color: propertyCubit.propertyType == 8
                              ? AppColors.primary
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  6.toWidth,
                  ButtonWidget(
                    onTap: () {
                      propertyCubit.changePropertyType(9);
                    },
                    color: Colors.white,
                    height: 0.085,
                    width: 0.2,
                    borderColor: propertyCubit.propertyType == 9
                        ? AppColors.primary
                        : Colors.black26,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/store.png',
                          height: 23,
                          width: 23,
                          color: propertyCubit.propertyType == 9
                              ? AppColors.primary
                              : Colors.black,
                        ),
                        4.toHeight,
                        TextWidget(
                          text: S.of(context).Shop,
                          fontSize: 14,
                          color: propertyCubit.propertyType == 9
                              ? AppColors.primary
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  6.toWidth,
                  ButtonWidget(
                    onTap: () {
                      propertyCubit.changePropertyType(20);
                    },
                    color: Colors.white,
                    height: 0.085,
                    width: 0.2,
                    borderColor: propertyCubit.propertyType == 20
                        ? AppColors.primary
                        : Colors.black26,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/office.png',
                          height: 23,
                          width: 23,
                          color: propertyCubit.propertyType == 20
                              ? AppColors.primary
                              : Colors.black,
                        ),
                        4.toHeight,
                        TextWidget(
                          text: S.of(context).Office,
                          fontSize: 14,
                          color: propertyCubit.propertyType == 20
                              ? AppColors.primary
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  6.toWidth,
                  ButtonWidget(
                    onTap: () {
                      propertyCubit.changePropertyType(11);
                    },
                    color: Colors.white,
                    height: 0.085,
                    width: 0.2,
                    borderColor: propertyCubit.propertyType == 11
                        ? AppColors.primary
                        : Colors.black26,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/land.png',
                          height: 23,
                          width: 23,
                          color: propertyCubit.propertyType == 11
                              ? AppColors.primary
                              : Colors.black,
                        ),
                        4.toHeight,
                        TextWidget(
                          text: S.of(context).Land,
                          fontSize: 14,
                          color: propertyCubit.propertyType == 11
                              ? AppColors.primary
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  6.toWidth,
                  ButtonWidget(
                    onTap: () {
                      propertyCubit.changePropertyType(12);
                    },
                    color: Colors.white,
                    height: 0.085,
                    width: 0.2,
                    borderColor: propertyCubit.propertyType == 12
                        ? AppColors.primary
                        : Colors.black26,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/house.png',
                          height: 23,
                          width: 23,
                          color: propertyCubit.propertyType == 12
                              ? AppColors.primary
                              : Colors.black,
                        ),
                        4.toHeight,
                        TextWidget(
                          text: S.of(context).Villa,
                          fontSize: 14,
                          color: propertyCubit.propertyType == 12
                              ? AppColors.primary
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  6.toWidth,
                  ButtonWidget(
                    onTap: () {
                      propertyCubit.changePropertyType(10);
                    },
                    color: Colors.white,
                    height: 0.085,
                    width: 0.2,
                    borderColor: propertyCubit.propertyType == 10
                        ? AppColors.primary
                        : Colors.black26,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/building.png',
                          height: 23,
                          width: 23,
                          color: propertyCubit.propertyType == 10
                              ? AppColors.primary
                              : Colors.black87,
                        ),
                        4.toHeight,
                        TextWidget(
                          text: S.of(context).Building,
                          fontSize: 14,
                          color: propertyCubit.propertyType == 10
                              ? AppColors.primary
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  6.toWidth,
                  ButtonWidget(
                    onTap: () {
                      propertyCubit.changePropertyType(13);
                    },
                    color: Colors.white,
                    height: 0.085,
                    width: 0.2,
                    borderColor: propertyCubit.propertyType == 13
                        ? AppColors.primary
                        : Colors.black26,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/factory.png',
                          height: 23,
                          width: 23,
                          color: propertyCubit.propertyType == 13
                              ? AppColors.primary
                              : Colors.black,
                        ),
                        4.toHeight,
                        TextWidget(
                          text: S.of(context).Factory,
                          fontSize: 14,
                          color: propertyCubit.propertyType == 13
                              ? AppColors.primary
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  propertyCubit.adType == 6 ? 0.toWidth : 6.toWidth,
                  propertyCubit.adType == 6
                      ? const SizedBox()
                      : ButtonWidget(
                          onTap: () {
                            propertyCubit.changePropertyType(7);
                          },
                          color: Colors.white,
                          height: 0.085,
                          width: 0.2,
                          borderColor: propertyCubit.propertyType == 7
                              ? AppColors.primary
                              : Colors.black26,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/room.png',
                                height: 23,
                                width: 23,
                                color: propertyCubit.propertyType == 7
                                    ? AppColors.primary
                                    : Colors.black,
                              ),
                              4.toHeight,
                              TextWidget(
                                text: S.of(context).Room,
                                fontSize: 14,
                                color: propertyCubit.propertyType == 7
                                    ? AppColors.primary
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                ],
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

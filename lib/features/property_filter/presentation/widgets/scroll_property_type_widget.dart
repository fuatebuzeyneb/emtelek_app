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

class ScrollPropertyTypeWidget extends StatelessWidget {
  const ScrollPropertyTypeWidget({
    super.key,
    required this.itIsRent,
  });

  final bool itIsRent;

  @override
  Widget build(BuildContext context) {
    PropertyFilterCubit propertyFilterCubit =
        BlocProvider.of<PropertyFilterCubit>(context);
    return BlocConsumer<PropertyFilterCubit, PropertyFilterState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ButtonWidget(
                onTap: () {
                  propertyFilterCubit.changePropertyType(itIsRent ? 8 : 14);
                },
                color: Colors.white,
                height: 0.085,
                width: 0.2,
                borderColor: propertyFilterCubit.propertyType == 8 ||
                        propertyFilterCubit.propertyType == 14
                    ? AppColors.primary
                    : Colors.black26,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/home.png',
                      height: 23,
                      width: 23,
                      color: propertyFilterCubit.propertyType == 8 ||
                              propertyFilterCubit.propertyType == 14
                          ? AppColors.primary
                          : Colors.black,
                    ),
                    4.toHeight,
                    TextWidget(
                      text: S.of(context).Apartment,
                      fontSize: 14,
                      color: propertyFilterCubit.propertyType == 8 ||
                              propertyFilterCubit.propertyType == 14
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
                  propertyFilterCubit.changePropertyType(itIsRent ? 9 : 15);
                },
                color: Colors.white,
                height: 0.085,
                width: 0.2,
                borderColor: propertyFilterCubit.propertyType == 9 ||
                        propertyFilterCubit.propertyType == 15
                    ? AppColors.primary
                    : Colors.black26,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/store.png',
                      height: 23,
                      width: 23,
                      color: propertyFilterCubit.propertyType == 9 ||
                              propertyFilterCubit.propertyType == 15
                          ? AppColors.primary
                          : Colors.black,
                    ),
                    4.toHeight,
                    TextWidget(
                      text: S.of(context).Shop,
                      fontSize: 14,
                      color: propertyFilterCubit.propertyType == 9 ||
                              propertyFilterCubit.propertyType == 15
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
                  propertyFilterCubit.changePropertyType(itIsRent ? 27 : 26);
                },
                color: Colors.white,
                height: 0.085,
                width: 0.2,
                borderColor: propertyFilterCubit.propertyType == 26 ||
                        propertyFilterCubit.propertyType == 27
                    ? AppColors.primary
                    : Colors.black26,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/office.png',
                      height: 23,
                      width: 23,
                      color: propertyFilterCubit.propertyType == 26 ||
                              propertyFilterCubit.propertyType == 27
                          ? AppColors.primary
                          : Colors.black,
                    ),
                    4.toHeight,
                    TextWidget(
                      text: S.of(context).Office,
                      fontSize: 14,
                      color: propertyFilterCubit.propertyType == 26 ||
                              propertyFilterCubit.propertyType == 27
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
                  propertyFilterCubit.changePropertyType(itIsRent ? 11 : 17);
                },
                color: Colors.white,
                height: 0.085,
                width: 0.2,
                borderColor: propertyFilterCubit.propertyType == 11 ||
                        propertyFilterCubit.propertyType == 17
                    ? AppColors.primary
                    : Colors.black26,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/land.png',
                      height: 23,
                      width: 23,
                      color: propertyFilterCubit.propertyType == 11 ||
                              propertyFilterCubit.propertyType == 17
                          ? AppColors.primary
                          : Colors.black,
                    ),
                    4.toHeight,
                    TextWidget(
                      text: S.of(context).Land,
                      fontSize: 14,
                      color: propertyFilterCubit.propertyType == 11 ||
                              propertyFilterCubit.propertyType == 17
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
                  propertyFilterCubit.changePropertyType(itIsRent ? 12 : 18);
                },
                color: Colors.white,
                height: 0.085,
                width: 0.2,
                borderColor: propertyFilterCubit.propertyType == 12 ||
                        propertyFilterCubit.propertyType == 18
                    ? AppColors.primary
                    : Colors.black26,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/house.png',
                      height: 23,
                      width: 23,
                      color: propertyFilterCubit.propertyType == 12 ||
                              propertyFilterCubit.propertyType == 18
                          ? AppColors.primary
                          : Colors.black,
                    ),
                    4.toHeight,
                    TextWidget(
                      text: S.of(context).Villa,
                      fontSize: 14,
                      color: propertyFilterCubit.propertyType == 12 ||
                              propertyFilterCubit.propertyType == 18
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
                  propertyFilterCubit.changePropertyType(itIsRent ? 10 : 16);
                },
                color: Colors.white,
                height: 0.085,
                width: 0.2,
                borderColor: propertyFilterCubit.propertyType == 10 ||
                        propertyFilterCubit.propertyType == 16
                    ? AppColors.primary
                    : Colors.black26,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/building.png',
                      height: 23,
                      width: 23,
                      color: propertyFilterCubit.propertyType == 10 ||
                              propertyFilterCubit.propertyType == 16
                          ? AppColors.primary
                          : Colors.black87,
                    ),
                    4.toHeight,
                    TextWidget(
                      text: S.of(context).Building,
                      fontSize: 14,
                      color: propertyFilterCubit.propertyType == 10 ||
                              propertyFilterCubit.propertyType == 16
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
                  propertyFilterCubit.changePropertyType(itIsRent ? 13 : 19);
                },
                color: Colors.white,
                height: 0.085,
                width: 0.2,
                borderColor: propertyFilterCubit.propertyType == 13 ||
                        propertyFilterCubit.propertyType == 19
                    ? AppColors.primary
                    : Colors.black26,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/factory.png',
                      height: 23,
                      width: 23,
                      color: propertyFilterCubit.propertyType == 13 ||
                              propertyFilterCubit.propertyType == 19
                          ? AppColors.primary
                          : Colors.black,
                    ),
                    4.toHeight,
                    TextWidget(
                      text: S.of(context).Factory,
                      fontSize: 14,
                      color: propertyFilterCubit.propertyType == 13 ||
                              propertyFilterCubit.propertyType == 19
                          ? AppColors.primary
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              propertyFilterCubit.adType == 6 ? 0.toWidth : 6.toWidth,
              propertyFilterCubit.adType == 6
                  ? const SizedBox()
                  : ButtonWidget(
                      onTap: () {
                        propertyFilterCubit.changePropertyType(7);
                      },
                      color: Colors.white,
                      height: 0.085,
                      width: 0.2,
                      borderColor: propertyFilterCubit.propertyType == 7
                          ? AppColors.primary
                          : Colors.black26,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/room.png',
                            height: 23,
                            width: 23,
                            color: propertyFilterCubit.propertyType == 7
                                ? AppColors.primary
                                : Colors.black,
                          ),
                          4.toHeight,
                          TextWidget(
                            text: S.of(context).Room,
                            fontSize: 14,
                            color: propertyFilterCubit.propertyType == 7
                                ? AppColors.primary
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}

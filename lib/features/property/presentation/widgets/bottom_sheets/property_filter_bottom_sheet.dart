import 'dart:ui';

import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/features/property/presentation/widgets/area_range_widget.dart';
import 'package:emtelek/features/property/presentation/widgets/scroll_property_type_widget.dart';
import 'package:emtelek/shared/common_pages/location_selection_page.dart';
import 'package:emtelek/features/property/presentation/pages/property_search_result_page.dart';
import 'package:emtelek/features/auth/presentation/pages/login_page.dart';
import 'package:emtelek/features/auth/presentation/pages/signup_page.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/widgets/price_range_widget.dart';
import 'package:emtelek/shared/widgets/tab_style_button_widget.dart';
import 'package:emtelek/shared/widgets/bottom_sheet_widget.dart';
import 'package:emtelek/shared/widgets/left_hint_text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class PropertyFilterBottomSheet extends StatelessWidget {
  const PropertyFilterBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PropertyCubit propertyCubit = BlocProvider.of<PropertyCubit>(context);
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);

    return BlocConsumer<PropertyCubit, PropertyState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return BottomSheetWidget(
          height: 1,
          widgetBody: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                SizedBox(height: context.height * 0.06),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        child: const Icon(Icons.close),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    SizedBox(
                      width: context.width * 0.01,
                    ),
                    TextWidget(
                      text: S.of(context).SearchFilters,
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    TextWidget(
                      text: S.of(context).Reset,
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                10.toHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TabStyleButtonWidget(
                      onTap: () {
                        propertyCubit.changeAdType(5);
                        propertyCubit.switchPropertyType();
                      },
                      fontSize: 16,
                      bottomColor: propertyCubit.adType == 5
                          ? AppColors.primary
                          : Colors.transparent,
                      colorText: propertyCubit.adType == 5
                          ? Colors.black
                          : Colors.grey,
                      text: S.of(context).Rent,
                    ),
                    TabStyleButtonWidget(
                      onTap: () {
                        propertyCubit.changeAdType(6);
                        propertyCubit.switchPropertyType();
                      },
                      bottomColor: propertyCubit.adType == 6
                          ? AppColors.primary
                          : Colors.transparent,
                      fontSize: 16,
                      colorText: propertyCubit.adType == 6
                          ? Colors.black
                          : Colors.grey,
                      text: S.of(context).Sale,
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      20.toHeight,
                      Row(
                        children: [
                          TextWidget(
                            text: S.of(context).Location,
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      10.toHeight,
                      ButtonWidget(
                        onTap: () {
                          pageTransition(context,
                              page: const SelectLocationFilterView());
                        },
                        color: Colors.white,
                        height: 0.06,
                        width: 1,
                        colorText: Colors.grey,
                        borderColor: Colors.grey,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20,
                              ),
                              SizedBox(width: 4),
                              TextWidget(
                                text: 'دمشق، اللاذقية، ادلب، سراقب، بانياس',
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                      6.toHeight,
                      Row(
                        children: [
                          TextWidget(
                            text: S.of(context).SelectCityOrRegion,
                            fontSize: 10,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      20.toHeight,
                      Row(
                        children: [
                          TextWidget(
                            text: S.of(context).PropertyType,
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      10.toHeight,
                      ScrollPropertyTypeWidget(
                          itIsRent: propertyCubit.adType == 5),
                      20.toHeight,
                      Row(
                        children: [
                          TextWidget(
                            text: S.of(context).NumberOfBedrooms,
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      10.toHeight,
                      SizedBox(
                        height: context.height * 0.04,
                        width: context.width * 1,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 12,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: propertyCubit.listRoomCount.contains(index)
                                  ? ButtonWidget(
                                      onTap: () {
                                        propertyCubit
                                            .removeListRoomCount(index);
                                      },
                                      color: Colors.white,
                                      height: 0.025,
                                      width: 0.15,
                                      borderColor: AppColors.primary,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Icons.done,
                                            size: 16,
                                            color: AppColors.primary,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: TextWidget(
                                              text: index == 11
                                                  ? '12+'
                                                  : '${index + 1}',
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
                                        propertyCubit.addListRoomCount(index);
                                      },
                                      color: Colors.white,
                                      height: 0.025,
                                      width: 0.085,
                                      borderColor: Colors.black26,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
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
                      20.toHeight,
                      Row(
                        children: [
                          TextWidget(
                            text: S.of(context).NumberOfBathrooms,
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      10.toHeight,
                      SizedBox(
                        height: context.height * 0.04,
                        width: context.width * 1,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 7,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: propertyCubit.listBathRoomCount
                                      .contains(index)
                                  ? ButtonWidget(
                                      onTap: () {
                                        propertyCubit
                                            .removeListBathRoomCount(index);
                                      },
                                      color: Colors.white,
                                      height: 0.025,
                                      width: 0.15,
                                      borderColor: AppColors.primary,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Icons.done,
                                            size: 16,
                                            color: AppColors.primary,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: TextWidget(
                                              text: index == 6
                                                  ? '7+'
                                                  : '${index + 1}',
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
                                        propertyCubit
                                            .addListBathRoomCount(index);
                                      },
                                      color: Colors.white,
                                      height: 0.025,
                                      width: 0.085,
                                      borderColor: Colors.black26,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: TextWidget(
                                              text: index == 6
                                                  ? '7+'
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
                      20.toHeight,
                      Row(
                        children: [
                          TextWidget(
                            text: S.of(context).FurnishedOrUnfurnished,
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      10.toHeight,
                      Row(
                        children: [
                          ButtonWidget(
                            paddingHorizontal: context.height * 0.02,
                            paddingVertical: context.height * 0.014,
                            height: 0,
                            width: 0,
                            onTap: () {
                              propertyCubit.changeFurnishedType(0);
                            },
                            color: Colors.white,
                            borderColor: propertyCubit.furnishedType == 0
                                ? AppColors.primary
                                : Colors.black26,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: TextWidget(
                                    text: S.of(context).All,
                                    color: propertyCubit.furnishedType == 0
                                        ? AppColors.primary
                                        : Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          6.toWidth,
                          ButtonWidget(
                            paddingHorizontal: context.height * 0.02,
                            paddingVertical: context.height * 0.014,
                            height: 0,
                            width: 0,
                            onTap: () {
                              propertyCubit.changeFurnishedType(1);
                            },
                            color: Colors.white,
                            borderColor: propertyCubit.furnishedType == 1
                                ? AppColors.primary
                                : Colors.black26,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: TextWidget(
                                    text: S.of(context).Furnished,
                                    color: propertyCubit.furnishedType == 1
                                        ? AppColors.primary
                                        : Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          6.toWidth,
                          ButtonWidget(
                            paddingHorizontal: context.height * 0.02,
                            paddingVertical: context.height * 0.014,
                            height: 0,
                            width: 0,
                            onTap: () {
                              propertyCubit.changeFurnishedType(2);
                            },
                            color: Colors.white,
                            borderColor: propertyCubit.furnishedType == 2
                                ? AppColors.primary
                                : Colors.black26,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: TextWidget(
                                    text: S.of(context).Unfurnished,
                                    color: propertyCubit.furnishedType == 2
                                        ? AppColors.primary
                                        : Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      20.toHeight,
                      Row(
                        children: [
                          TextWidget(
                            text: S.of(context).PostedBy,
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      10.toHeight,
                      Row(
                        children: [
                          ButtonWidget(
                            paddingHorizontal: context.height * 0.02,
                            paddingVertical: context.height * 0.014,
                            height: 0,
                            width: 0,
                            onTap: () {
                              propertyCubit.changePostedByType(0);
                            },
                            color: Colors.white,
                            borderColor: propertyCubit.sellerType == 0
                                ? AppColors.primary
                                : Colors.black26,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: TextWidget(
                                    text: S.of(context).All,
                                    color: propertyCubit.sellerType == 0
                                        ? AppColors.primary
                                        : Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          6.toWidth,
                          ButtonWidget(
                            paddingHorizontal: context.height * 0.02,
                            paddingVertical: context.height * 0.014,
                            height: 0,
                            width: 0,
                            onTap: () {
                              propertyCubit.changePostedByType(1);
                            },
                            color: Colors.white,
                            borderColor: propertyCubit.sellerType == 1
                                ? AppColors.primary
                                : Colors.black26,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: TextWidget(
                                    text: S.of(context).Owner,
                                    color: propertyCubit.sellerType == 1
                                        ? AppColors.primary
                                        : Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          6.toWidth,
                          ButtonWidget(
                            paddingHorizontal: context.height * 0.02,
                            paddingVertical: context.height * 0.014,
                            height: 0,
                            width: 0,
                            onTap: () {
                              propertyCubit.changePostedByType(2);
                            },
                            color: Colors.white,
                            borderColor: propertyCubit.sellerType == 2
                                ? AppColors.primary
                                : Colors.black26,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: TextWidget(
                                    text: S.of(context).Agent,
                                    color: propertyCubit.sellerType == 2
                                        ? AppColors.primary
                                        : Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      20.toHeight,
                      Row(
                        children: [
                          TextWidget(
                            text: S.of(context).Price,
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const PriceRangeWidget(),
                      20.toHeight,
                      Row(
                        children: [
                          TextWidget(
                            text: S.of(context).Area,
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const AreaRangeWidget(),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonWidget(
                    onTap: () {
                      Navigator.pop(context);
                      propertyCubit.applyFilter(
                          listCityIds: settingsCubit.selectedCityIds,
                          listDistrictIds: settingsCubit.selectedDistrictIds,
                          minPrice: settingsCubit.minPrice?.toInt(),
                          maxPrice: settingsCubit.maxPrice?.toInt());
                      pageTransition(context,
                          page: const PropertySearchResultPage());
                    },
                    text: S.of(context).Apply,
                    height: 0.06,
                    width: 1,
                    color: Colors.black,
                    fontSize: 18,
                    colorText: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

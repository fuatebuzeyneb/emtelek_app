import 'dart:ui';

import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/property/data/models/property_filter_request_mode.dart';
import 'package:emtelek/features/property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/features/property_filter/data/models/property_filter_request_model.dart';
import 'package:emtelek/features/property_filter/domain/cubit/property_filter_cubit.dart';
import 'package:emtelek/features/property_filter/presentation/widgets/area_range_widget.dart';
import 'package:emtelek/features/property_filter/presentation/widgets/scroll_property_type_widget.dart';
import 'package:emtelek/shared/common_pages/location_selection_page.dart';
import 'package:emtelek/features/property_filter/presentation/pages/property_search_result_page.dart';
import 'package:emtelek/features/auth/presentation/pages/login_page.dart';
import 'package:emtelek/features/auth/presentation/pages/signup_page.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
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
    PropertyFilterCubit propertyFilterCubit =
        BlocProvider.of<PropertyFilterCubit>(context);
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);

    return BlocConsumer<PropertyFilterCubit, PropertyFilterState>(
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
                        propertyFilterCubit.changeAdType(5);
                        propertyFilterCubit.switchPropertyType();
                      },
                      fontSize: 16,
                      bottomColor: propertyFilterCubit.adType == 5
                          ? AppColors.primary
                          : Colors.transparent,
                      colorText: propertyFilterCubit.adType == 5
                          ? Colors.black
                          : Colors.grey,
                      text: S.of(context).Rent,
                    ),
                    TabStyleButtonWidget(
                      onTap: () {
                        propertyFilterCubit.changeAdType(6);
                        propertyFilterCubit.switchPropertyType();
                      },
                      bottomColor: propertyFilterCubit.adType == 6
                          ? AppColors.primary
                          : Colors.transparent,
                      fontSize: 16,
                      colorText: propertyFilterCubit.adType == 6
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
                          itIsRent: propertyFilterCubit.adType == 5),
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
                              child: propertyFilterCubit.listRoomCount
                                      .contains(index)
                                  ? ButtonWidget(
                                      onTap: () {
                                        propertyFilterCubit
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
                                        propertyFilterCubit
                                            .addListRoomCount(index);
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
                              child: propertyFilterCubit.listBathRoomCount
                                      .contains(index)
                                  ? ButtonWidget(
                                      onTap: () {
                                        propertyFilterCubit
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
                                        propertyFilterCubit
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
                              propertyFilterCubit.changeFurnishedType(0);
                            },
                            color: Colors.white,
                            borderColor: propertyFilterCubit.furnishedType == 0
                                ? AppColors.primary
                                : Colors.black26,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: TextWidget(
                                    text: S.of(context).All,
                                    color:
                                        propertyFilterCubit.furnishedType == 0
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
                              propertyFilterCubit.changeFurnishedType(1);
                            },
                            color: Colors.white,
                            borderColor: propertyFilterCubit.furnishedType == 1
                                ? AppColors.primary
                                : Colors.black26,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: TextWidget(
                                    text: S.of(context).Furnished,
                                    color:
                                        propertyFilterCubit.furnishedType == 1
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
                              propertyFilterCubit.changeFurnishedType(2);
                            },
                            color: Colors.white,
                            borderColor: propertyFilterCubit.furnishedType == 2
                                ? AppColors.primary
                                : Colors.black26,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: TextWidget(
                                    text: S.of(context).Unfurnished,
                                    color:
                                        propertyFilterCubit.furnishedType == 2
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
                              propertyFilterCubit.changePostedByType(0);
                            },
                            color: Colors.white,
                            borderColor: propertyFilterCubit.sellerType == 0
                                ? AppColors.primary
                                : Colors.black26,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: TextWidget(
                                    text: S.of(context).All,
                                    color: propertyFilterCubit.sellerType == 0
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
                              propertyFilterCubit.changePostedByType(1);
                            },
                            color: Colors.white,
                            borderColor: propertyFilterCubit.sellerType == 1
                                ? AppColors.primary
                                : Colors.black26,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: TextWidget(
                                    text: S.of(context).Owner,
                                    color: propertyFilterCubit.sellerType == 1
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
                              propertyFilterCubit.changePostedByType(2);
                            },
                            color: Colors.white,
                            borderColor: propertyFilterCubit.sellerType == 2
                                ? AppColors.primary
                                : Colors.black26,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: TextWidget(
                                    text: S.of(context).Agent,
                                    color: propertyFilterCubit.sellerType == 2
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
                      //    const AreaRangeWidget(),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonWidget(
                    onTap: () {
                      Navigator.pop(context);
                      propertyFilterCubit.getFilterAds(
                          propertyFilterRequestModel:
                              PropertyFilterRequestModel(
                                  token: getIt<CacheHelper>()
                                      .getDataString(key: 'token'),
                                  clientId: getIt<CacheHelper>()
                                      .getData(key: 'clientId'),
                                  minPrice: settingsCubit.minPrice?.toInt(),
                                  maxPrice: settingsCubit.maxPrice?.toInt(),
                                  categoryId: propertyFilterCubit.propertyType,
                                  sellerType:
                                      propertyFilterCubit.sellerType == 0
                                          ? null
                                          : propertyFilterCubit.sellerType,
                                  districtId:
                                      settingsCubit.selectedDistrictIds.isEmpty
                                          ? null
                                          : settingsCubit.selectedDistrictIds,
                                  cityId: settingsCubit.selectedCityIds.isEmpty
                                      ? null
                                      : settingsCubit.selectedCityIds,
                                  minTotalArea:
                                      propertyFilterCubit.maxArea?.toInt(),
                                  maxTotalArea:
                                      propertyFilterCubit.minArea?.toInt(),
                                  roomCount:
                                      propertyFilterCubit.listRoomCount.isEmpty
                                          ? null
                                          : propertyFilterCubit.listRoomCount,
                                  bathroomCount: propertyFilterCubit
                                          .listBathRoomCount.isEmpty
                                      ? null
                                      : propertyFilterCubit.listBathRoomCount,
                                  furnish: propertyFilterCubit.furnishedType ==
                                          0
                                      ? null
                                      : propertyFilterCubit.furnishedType == 1
                                          ? 'true'
                                          : 'false',
                                  orderBy: null,
                                  searchTitle: null,
                                  page: 0));

                      pageTransition(context,
                          page: const PropertySearchResultPage());
                      // Navigator.pop(context);
                      // propertyFilterCubit.applyFilter(
                      //     listCityIds: settingsCubit.selectedCityIds,
                      //     listDistrictIds: settingsCubit.selectedDistrictIds,
                      //     minPrice: settingsCubit.minPrice?.toInt(),
                      //     maxPrice: settingsCubit.maxPrice?.toInt());
                      // pageTransition(context,
                      //     page: const PropertySearchResultPage());
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

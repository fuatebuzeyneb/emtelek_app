import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/auth/domain/auth_cubit/auth_cubit.dart';
import 'package:emtelek/features/property/data/models/property_filter_request_mode.dart';
import 'package:emtelek/features/property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/features/property_filter/domain/cubit/property_filter_cubit.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/features/auth/presentation/pages/login_page.dart';
import 'package:emtelek/features/auth/presentation/pages/signup_page.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/widgets/bottom_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PropertyRentOrSaleBottomSheet extends StatelessWidget {
  const PropertyRentOrSaleBottomSheet({
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
                const TextWidget(
                  text: 'الغرض من البحث',
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                8.toHeight,
                const TextWidget(
                  text: 'اختر الغرض من البحث',
                  fontSize: 14,
                  color: Colors.grey,
                  // fontWeight: FontWeight.bold,
                ),
                24.toHeight,
                Row(children: [
                  ButtonWidget(
                      paddingHorizontal: 12,
                      paddingVertical: 8,
                      onTap: () {
                        propertyFilterCubit.changeAdType(6);
                        propertyFilterCubit.switchPropertyType();
                      },
                      text: 'للبيع',
                      color: propertyFilterCubit.adType == 6
                          ? Colors.grey.shade200
                          : Colors.white,
                      colorText: propertyFilterCubit.adType == 6
                          ? Colors.black
                          : Colors.grey,
                      borderColor: propertyFilterCubit.adType == 6
                          ? Colors.black
                          : Colors.grey,
                      borderRadius: 8,
                      width: 0,
                      height: 0),
                  8.toWidth,
                  ButtonWidget(
                      paddingHorizontal: 12,
                      paddingVertical: 8,
                      onTap: () {
                        propertyFilterCubit.changeAdType(5);
                        propertyFilterCubit.switchPropertyType();
                      },
                      text: 'للإيجار',
                      color: propertyFilterCubit.adType == 5
                          ? Colors.grey.shade200
                          : Colors.white,
                      colorText: propertyFilterCubit.adType == 5
                          ? Colors.black
                          : Colors.grey,
                      borderColor: propertyFilterCubit.adType == 5
                          ? Colors.black
                          : Colors.grey,
                      borderRadius: 8,
                      width: 0,
                      height: 0),
                ]),
                const Spacer(),
                ButtonWidget(
                    paddingHorizontal: 12,
                    paddingVertical: 8,
                    onTap: () {
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

                      // applyFilter(
                      //     listCityIds: settingsCubit.selectedCityIds,
                      //     listDistrictIds: settingsCubit.selectedDistrictIds,
                      //     minPrice: settingsCubit.minPrice?.toInt(),
                      //     maxPrice: settingsCubit.maxPrice?.toInt());
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
      },
    );
  }
}

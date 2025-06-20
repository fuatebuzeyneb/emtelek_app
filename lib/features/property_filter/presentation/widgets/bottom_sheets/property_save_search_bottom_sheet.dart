import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/snackbar_utils.dart';
import 'package:emtelek/features/property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/features/property_filter/data/models/save_search_filter_request_model.dart';
import 'package:emtelek/features/property_filter/domain/cubit/property_filter_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/widgets/bottom_sheet_widget.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PropertySaveSearchBottomSheet extends StatelessWidget {
  const PropertySaveSearchBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PropertyFilterCubit propertyFilterCubit =
        BlocProvider.of<PropertyFilterCubit>(context);
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    return BlocConsumer<PropertyFilterCubit, PropertyFilterState>(
      listener: (context, state) {
        if (state is SaveSearchPropertyFilterSuccess) {
          SnackbarUtils.showSnackbar(context, "تم الحفظ بنجاح");
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return BottomSheetWidget(
          circularRadius: 12,
          height: 0.4,
          widgetBody: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 0.0), // EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Image.asset(
                  'assets/images/bookmark.jpg',
                  height: context.height * 0.1,
                  width: context.width * 0.3,
                ),
                8.toHeight,
                TextWidget(
                  text: S.of(context).SaveSearch,
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                Divider(),
                8.toHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const TextWidget(
                      text: 'اسم لهذا البحث',
                      fontSize: 14,
                      color: Colors.grey,
                      // fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                8.toHeight,
                TextFieldWidget(
                  paddingVertical: 4,
                  hint: 'اسم لهذا البحث',
                  onChanged: (value) {
                    propertyFilterCubit.titleOfSavedSearch = value;
                  },
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonWidget(
                        paddingHorizontal: 12,
                        paddingVertical: 8,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        text: S.of(context).Cancel,
                        color: AppColors.primary,
                        colorText: Colors.white,
                        borderColor: AppColors.primary,
                        borderRadius: 8,
                        width: 0.44,
                        height: 0.055),
                    ButtonWidget(
                        paddingHorizontal: 12,
                        paddingVertical: 8,
                        onTap: () {
                          propertyFilterCubit.saveSearchFilter(
                              saveSearchFilterRequestModel:
                                  SaveSearchFilterRequestModel(
                            filterName: propertyFilterCubit.titleOfSavedSearch,
                            categoryId: propertyFilterCubit.propertyType!,
                            token: getIt<CacheHelper>().getData(key: 'token'),
                            clintId:
                                getIt<CacheHelper>().getData(key: 'clientId'),
                            minPrice: settingsCubit.minPrice,
                            maxPrice: settingsCubit.maxPrice,
                            bathroomCount:
                                propertyFilterCubit.listBathRoomCount,
                            districtId: settingsCubit.selectedDistrictIds,
                            cityId: settingsCubit.selectedCityIds,
                            minTotalArea: propertyFilterCubit.minArea,
                            maxTotalArea: propertyFilterCubit.maxArea,
                            roomCount: propertyFilterCubit.listRoomCount,
                            sellerType: propertyFilterCubit.sellerType,
                            furnish: propertyFilterCubit.furnishedType == 1
                                ? true
                                : propertyFilterCubit.furnishedType == 0
                                    ? false
                                    : null,
                          ));
                        },
                        text: state is SaveSearchPropertyFilterLoading
                            ? 'wait...'
                            : S.of(context).Save,
                        color: AppColors.primary,
                        colorText: Colors.white,
                        borderColor: AppColors.primary,
                        borderRadius: 8,
                        width: 0.44,
                        height: 0.055),
                  ],
                ),
                16.toHeight
              ],
            ),
          ),
        );
      },
    );
  }
}

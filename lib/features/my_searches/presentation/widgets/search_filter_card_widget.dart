import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/features/my_searches/data/models/delete_one_my_search_request_model.dart';
import 'package:emtelek/features/my_searches/domain/cubit/my_searches_cubit.dart';
import 'package:emtelek/features/my_searches/presentation/pages/my_searches_page.dart';
import 'package:emtelek/features/property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/features/my_searches/data/models/get_my_searches_response_model.dart';
import 'package:emtelek/features/property_filter/data/models/property_filter_request_model.dart';
import 'package:emtelek/features/property_filter/domain/cubit/property_filter_cubit.dart';
import 'package:emtelek/features/property_filter/presentation/pages/property_search_result_page.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/widgets/appbar_widget.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/loading_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFilterCardWidget extends StatelessWidget {
  final SearchFilterItemModel itemContent;
  const SearchFilterCardWidget({
    super.key,
    required this.itemContent,
  });

  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);

    return ButtonWidget(
      onTap: () {
        BlocProvider.of<PropertyFilterCubit>(context).getFilterAds(
            propertyFilterRequestModel: PropertyFilterRequestModel(
                token: getIt<CacheHelper>().getDataString(key: 'token'),
                clientId: getIt<CacheHelper>().getData(key: 'clientId'),
                minPrice: itemContent.content.minPrice,
                maxPrice: itemContent.content.maxPrice,
                categoryId: itemContent.content.categoryId,
                sellerType: null,
                districtId: itemContent.content.districtId,
                cityId: itemContent.content.cityId,
                minTotalArea: itemContent.content.minTotalArea?.toInt(),
                maxTotalArea: itemContent.content.maxTotalArea?.toInt(),
                roomCount: itemContent.content.roomCount,
                bathroomCount: itemContent.content.bathroomCount,
                furnish: null,
                orderBy: null,
                searchTitle: null,
                page: 0));
        // propertyCubit.applyFilter(
        //     listCityIds: [],
        //     listDistrictIds: [],
        //     minPrice: null,
        //     maxPrice: null);
        // propertyCubit.propertyType =
        //     int.tryParse(content!.categoryId.toString()) ?? 0;
        pageTransition(context, page: const PropertySearchResultPage());
      },
      color: Colors.white,
      height: 0,
      width: context.width * 1,
      borderRadius: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextWidget(
                  text:
                      "${settingsCubit.getCategoryName(itemContent.content.categoryId)} ${settingsCubit.isForSale(itemContent.content.categoryId)}",
                  fontSize: 14,
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<MySearchesCubit>(context).deleteOneMySearch(
                        deleteOneMySearchRequestModel:
                            DeleteOneMySearchRequestModel(
                      searchId: itemContent.searchId,
                      clientId: getIt<CacheHelper>().getData(key: 'clientId'),
                      token: getIt<CacheHelper>().getDataString(key: 'token')!,
                    ));
                  },
                  child: Icon(Icons.delete, color: Colors.redAccent),
                )
              ],
            ),
            4.toHeight,
            TextWidget(
                text: itemContent.searchTitle,
                fontSize: 16,
                fontWeight: FontWeight.bold),
            8.toHeight,
            if (itemContent.content.cityId != null) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: itemContent.content.cityId!
                    .map(
                      (id) => ButtonWidget(
                        paddingHorizontal: 12,
                        paddingVertical: 6,
                        borderRadius: 4,
                        height: 0,
                        width: 0.2,
                        onTap: () {},
                        text: settingsCubit.getCityNameByCityId(id),
                        color: Colors.grey,
                      ),
                    )
                    .toList(),
              ),
            ] else ...[
              SizedBox()
            ],
            itemContent.content.cityId != null ? 8.toHeight : 0.toHeight,
            if (itemContent.content.districtId != null) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: itemContent.content.districtId!
                    .map(
                      (id) => ButtonWidget(
                        paddingHorizontal: 12,
                        paddingVertical: 6,
                        borderRadius: 4,
                        height: 0,
                        width: 0.2,
                        onTap: () {},
                        text: settingsCubit.getDistrictNameByDistrictId(id),
                        color: Colors.grey,
                      ),
                    )
                    .toList(),
              ),
            ] else ...[
              SizedBox()
            ],
            itemContent.content.districtId != null ? 8.toHeight : 0.toHeight,
            Row(
              children: [
                if (itemContent.content.roomCount != null) ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'عدد الغرف ${itemContent.content.roomCount!.join(',')}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ] else ...[
                  SizedBox()
                ],
                8.toWidth,
                if (itemContent.content.bathroomCount != null) ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'عدد الحمامات ${itemContent.content.bathroomCount!.join(',')}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ] else ...[
                  SizedBox()
                ],
              ],
            ),
            itemContent.content.bathroomCount != null ||
                    itemContent.content.roomCount != null
                ? 8.toHeight
                : 0.toHeight,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                itemContent.content.minPrice == null
                    ? SizedBox()
                    : ButtonWidget(
                        paddingHorizontal: 12,
                        paddingVertical: 6,
                        borderRadius: 4,
                        height: 0,
                        width: 0,
                        onTap: () {},
                        text:
                            "اقل سعر ${itemContent.content.minPrice} ${getIt<CacheHelper>().getDataString(key: 'currencyCode')!}",
                        color: Colors.grey,
                      ),
                8.toWidth,
                itemContent.content.maxPrice == null
                    ? SizedBox()
                    : ButtonWidget(
                        paddingHorizontal: 12,
                        paddingVertical: 6,
                        borderRadius: 4,
                        height: 0,
                        width: 0,
                        onTap: () {},
                        text:
                            "اعلى سعر ${itemContent.content.maxPrice} ${getIt<CacheHelper>().getDataString(key: 'currencyCode')!}",
                        color: Colors.grey,
                      ),
              ],
            ),
            itemContent.content.maxPrice != null ||
                    itemContent.content.minPrice != null
                ? 8.toHeight
                : 0.toHeight,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                itemContent.content.minTotalArea == null
                    ? SizedBox()
                    : ButtonWidget(
                        paddingHorizontal: 12,
                        paddingVertical: 6,
                        borderRadius: 4,
                        height: 0,
                        width: 0,
                        onTap: () {},
                        text:
                            "اقل مساحه ${itemContent.content.minTotalArea} ${S.current.SquareMeter}",
                        color: Colors.grey,
                      ),
                8.toWidth,
                itemContent.content.maxTotalArea == null
                    ? SizedBox()
                    : ButtonWidget(
                        paddingHorizontal: 12,
                        paddingVertical: 6,
                        borderRadius: 4,
                        height: 0,
                        width: 0,
                        onTap: () {},
                        text:
                            "اعلى مساحه ${itemContent.content.maxTotalArea} ${S.current.SquareMeter}",
                        color: Colors.grey,
                      ),
              ],
            ),
            12.toHeight,
            TextWidget(
              text: "تم حفظ هذا البحث في ${itemContent.date.substring(0, 10)}",
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ],
        ),
      ),
    );
  }
}

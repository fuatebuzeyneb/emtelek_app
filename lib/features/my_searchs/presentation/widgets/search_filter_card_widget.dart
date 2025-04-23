import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/features/my_searchs/presentation/pages/my_searches_page.dart';
import 'package:emtelek/features/search_property/data/models/get_save_search_model.dart';
import 'package:emtelek/features/search_property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/features/search_property/presentation/pages/property_search_result_page.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/widgets/appbar_widget.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/loading_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFilterCardWidget extends StatelessWidget {
  final int index;
  const SearchFilterCardWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    PropertyCubit propertyCubit = BlocProvider.of<PropertyCubit>(context);
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    final content = propertyCubit.searchFilterList[index].content;

    return ButtonWidget(
      onTap: () {
        // propertyCubit.applyFilter(
        //     listCityIds: [],
        //     listDistrictIds: [],
        //     minPrice: null,
        //     maxPrice: null);
        // propertyCubit.propertyType =
        //     int.tryParse(content!.categoryId.toString()) ?? 0;
        // pageTransition(context, page: const PropertySearchResultPage());
      },
      color: Colors.white,
      height: 0,
      width: context.width * 1,
      borderRadius: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                //  propertyCubit.searchFilterList[index].content != null
                //       ? propertyCubit.searchFilterList[index].content!.roomCount
                //           .toString()
                //       : ''.toString() + ' - ',
                TextWidget(
                  text: content is ContentModel && content.categoryId != null
                      ? "${settingsCubit.isForSale(int.tryParse(content.categoryId.toString()) ?? 0)} - ${settingsCubit.getCategoryName(int.tryParse(content.categoryId.toString()) ?? 0)}"
                      : ' ',
                  fontSize: 16,
                ),
                // 4.toWidth,
                // TextWidget(
                //   text: 'شقه',
                //   fontSize: 16,
                // ),
                Spacer(),
                Icon(Icons.more_vert_rounded)
              ],
            ),
            4.toHeight,
            TextWidget(
              text: propertyCubit.searchFilterList[index].searchTitle!,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            12.toHeight,
            if (content is ContentModel && content.cityId != null) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: content.cityId!
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
              Text(' لا توجد مدن محدده'),
            ],
            12.toHeight,
            if (content is ContentModel && content.districtId != null) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: content.districtId!
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
              Text(' لا توجد مناطق محدده'),
            ],
            // Row(
            //   children: [
            //     ButtonWidget(
            //       paddingHorizontal: 12,
            //       paddingVertical: 6,
            //       borderRadius: 4,
            //       height: 0,
            //       width: 0,
            //       onTap: () {},
            //       text: 'دمشق',
            //       color: Colors.grey,
            //     ),
            //     4.toWidth,
            //     ButtonWidget(
            //       paddingHorizontal: 12,
            //       paddingVertical: 6,
            //       borderRadius: 4,
            //       height: 0,
            //       width: 0,
            //       onTap: () {},
            //       text: 'حمص',
            //       color: Colors.grey,
            //     ),
            //     4.toWidth,
            // ButtonWidget(
            //   paddingHorizontal: 12,
            //   paddingVertical: 6,
            //   borderRadius: 4,
            //   height: 0,
            //   width: 0,
            //   onTap: () {},
            //   text: 'عدد الغرف 1,2,3,6',
            //   color: Colors.grey,
            // )
            //   ],
            // ),
            12.toHeight,
            if (content is ContentModel &&
                content.roomCount != null &&
                content.roomCount!.isNotEmpty) ...[
              GestureDetector(
                onTap: () {
                  // اكشن الضغط
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'عدد الغرف ${content.roomCount!.join(',')}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ] else ...[
              Text('لا يوجد عدد غرف محدد'),
            ],
            24.toHeight,
            TextWidget(
              text: 'تمام الحفظ بتاريخ 12/12/2022',
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ],
        ),
      ),
    );
  }
}

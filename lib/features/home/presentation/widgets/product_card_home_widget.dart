import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/home/data/models/get_home_response_model.dart';
import 'package:emtelek/features/home/data/models/property_model.dart';
import 'package:emtelek/features/home/domain/cubit/home_cubit.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/features/property/presentation/pages/property_details_page.dart';
import 'package:emtelek/shared/helper/founctions/formatter.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCardHomeWidget extends StatelessWidget {
  const ProductCardHomeWidget({super.key, required this.property});

  // final int index;
  // final int witchType; // 1 for sale property, 2 for rent property, 3 vehicles

  final Property property;

  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          pageTransition(context,
              page: PropertyDetailsPage(
                adDetails: property,
              ));
        },
        child: Container(
          height: context.height * 0.22,
          width: context.width * 0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // لون الظل
                spreadRadius: 1, // مدى انتشار الظل
                blurRadius: 1, // مقدار الضبابية
                offset: const Offset(0, 2), // إزاحة الظل (x, y)
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4, // تخصيص 60% من المساحة للصورة
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Image.network(
                    '${EndPoints.adImageUrl}${property.mainImage!}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Expanded(
                flex: 3, // تخصيص 40% من المساحة للنصوص
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: Formatter.formatNumber(
                                //adsModel.price
                                BlocProvider.of<SettingsCubit>(context)
                                    .convertToAppCurrency(
                                        adCurrencyCode: property.currency!,
                                        adPrice: property.price!)),
                            fontSize: 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          2.toWidth,
                          TextWidget(
                            text: getIt<CacheHelper>()
                                .getDataString(key: 'currencyCode')!,
                            fontSize: 12,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      1.toHeight,
                      Visibility(
                        visible: [12, 26, 8, 27, 18, 14]
                            .contains(property.categoryId),
                        child: TextWidget(
                          text:
                              '${property.data.info.roomCount} ${S.of(context).Room}  '
                              '${property.data.info.bathroomCount} ${S.of(context).Bathroom}',
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Visibility(
                        visible: ![12, 26, 8, 27, 18, 14]
                            .contains(property.categoryId),
                        child: TextWidget(
                          text:
                              '${S.current.Area} ${property.data.info.totalArea} ${S.of(context).SquareMeter}',
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      1.toHeight,
                      TextWidget(
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        isHaveOverflow: true,
                        text:
                            '${property.data.info.address}, ${property.data.district.districtName},  ${property.data.city!.cityName}',
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

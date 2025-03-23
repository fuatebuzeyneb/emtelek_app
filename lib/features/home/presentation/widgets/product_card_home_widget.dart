import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/home/domain/cubit/home_cubit.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/features/search_property/presentation/pages/property_details_page.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCardHomeWidget extends StatelessWidget {
  const ProductCardHomeWidget({super.key, required this.adsModel});

  // final int index;
  // final int witchType; // 1 for sale property, 2 for rent property, 3 vehicles

  final AdsModel adsModel;

  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          pageTransition(context,
              page: PropertyDetailsPage(
                adsModel: adsModel,
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
                  child: Image.asset(
                    'assets/images/example.png',
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
                            text: adsModel.price.toString(),
                            fontSize: 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          TextWidget(
                            text: adsModel.currency.toString(),
                            fontSize: 12,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      1.toHeight,
                      TextWidget(
                        text: '${adsModel.roomCount}' +
                            ' ' +
                            S.of(context).Room +
                            ' ' +
                            '${adsModel.bathroomCount}' +
                            ' ' +
                            S.of(context).Bathroom,
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      1.toHeight,
                      TextWidget(
                        text: '${adsModel.address}' +
                            ' ' +
                            '${adsModel.districtName}' +
                            ' ' +
                            '${adsModel.cityName}',
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

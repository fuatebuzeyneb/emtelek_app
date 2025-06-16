import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/features/add_property_listing/presentation/pages/add_or_edit_ad_details_page.dart';
import 'package:emtelek/features/my_ads/data/models/ad_model.dart';
import 'package:emtelek/features/my_ads/data/models/delete_ad_request_model.dart';
import 'package:emtelek/features/my_ads/data/models/get_my_ads_response_model.dart';
import 'package:emtelek/features/my_ads/domain/cubit/my_ads_cubit.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/features/my_ads/presentation/pages/edit_ad_details_page.dart';
import 'package:emtelek/features/property_filter/presentation/pages/property_details_page.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/helper/founctions/formatter.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/widgets/alert_dialog_widget.dart';
import 'package:emtelek/shared/widgets/appbar_widget.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAdCardWidget extends StatelessWidget {
  final int index;
  final GetMyAdsResponseModel adDetails;
  const MyAdCardWidget({
    super.key,
    required this.index,
    required this.adDetails,
  });

  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
      child: ButtonWidget(
        showElevation: true,
        boxShadowOpacity: 0.2,
        onTap: () {
          pageTransition(context,
              page: PropertyDetailsPage(
                adDetails: adDetails.property,
              ));
        },
        color: Colors.white,
        width: 1,
        height: 0.19,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: adDetails.property.adTitle!,
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        children: [
                          TextWidget(
                            text: settingsCubit
                                .convertToAppCurrency(
                                  adPrice: adDetails.property.price!,
                                  adCurrencyCode: adDetails.property.currency!,
                                )
                                .toStringAsFixed(2),
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          8.toWidth,
                          TextWidget(
                            text: Formatter.convertCurrencySymbol(
                                getIt<CacheHelper>()
                                    .getDataString(key: 'currencyCode')!),
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                      height: context.height * 0.08,
                      width: context.width * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${EndPoints.adImageUrl}${adDetails.property.mainImage}"),
                              fit: BoxFit.cover)))
                ],
              ),
              8.toHeight,
              Row(
                children: [
                  TextWidget(
                    text:
                        '${S.current.publishDate} ${adDetails.property.publishDate}',
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  Spacer(),
                  TextWidget(
                    text: context
                        .read<SettingsCubit>()
                        .getStatusInfo(adDetails.property.status!)['text'],
                    color: context
                        .read<SettingsCubit>()
                        .getStatusInfo(adDetails.property.status!)['color'],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
              12.toHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonWidget(
                    onTap: () {
                      pageTransition(context,
                          page: AddOrEditAdDetailsPage(
                            indexForEdit: index,
                            itIsEdit: true,
                          ));
                    },
                    color: Colors.green,
                    colorText: Colors.white,
                    height: 0.04,
                    width: 0.4,
                    text: 'تعديل',
                    fontSize: 14,
                  ),
                  // ButtonWidget(
                  //   onTap: () {
                  // pageTransition(context,
                  //     page: PropertyDetailsPage(
                  //       adDetails: adDetails.property,
                  //     ));
                  //   },
                  //   color: Colors.grey,
                  //   colorText: Colors.white,
                  //   height: 0.04,
                  //   width: 0.27,
                  //   text: 'معاينة',
                  //   fontSize: 14,
                  // ),
                  ButtonWidget(
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialogWidget(
                            title: 'تنبيه!!',
                            subtitle: 'سوف يتم حذف الاعلان بشكل نهائي',
                            widget: Icon(
                              Icons.info,
                              color: Colors.red,
                            ),
                            onYes: () {
                              Navigator.pop(context);

                              BlocProvider.of<MyAdsCubit>(context)
                                  .deleteAdProperty(
                                      deleteAdRequestModel:
                                          DeleteAdRequestModel(
                                              adId: adDetails.property.adId,
                                              token:
                                                  getIt<CacheHelper>()
                                                      .getDataString(
                                                          key: 'token')!,
                                              clientId: getIt<CacheHelper>()
                                                  .getData(key: 'clientId')));
                            },
                            onNo: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                    color: Colors.red,
                    colorText: Colors.white,
                    height: 0.04,
                    width: 0.4,
                    text: 'حذف',
                    fontSize: 14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

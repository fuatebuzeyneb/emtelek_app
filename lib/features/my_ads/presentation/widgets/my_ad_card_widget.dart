import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/features/add_listing/presentation/pages/add_ad_details_page.dart';
import 'package:emtelek/features/my_ads/domain/cubit/my_ads_cubit.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/features/my_ads/presentation/pages/edit_ad_details_page.dart';
import 'package:emtelek/features/search_property/presentation/pages/property_details_page.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/helper/founctions/formatter.dart';
import 'package:emtelek/shared/widgets/appbar_widget.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAdCardWidget extends StatelessWidget {
  final int index;
  final List<AdModel> myAdsList;
  const MyAdCardWidget({
    super.key,
    required this.index,
    required this.myAdsList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
      child: ButtonWidget(
        showElevation: true,
        boxShadowOpacity: 0.2,
        onTap: () {},
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
                        text: myAdsList[index].adTitle! +
                            ' ' +
                            "${myAdsList[index].categoryId}",
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        children: [
                          TextWidget(
                            text: Formatter.convertCurrencySymbol(
                                myAdsList[index].currency!),
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          8.toWidth,
                          TextWidget(
                            text: double.parse(myAdsList[index].price!)
                                .toStringAsFixed(2),
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                      height: context.height * 0.06,
                      width: context.width * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage('assets/images/example.png'),
                            fit: BoxFit.contain,
                          )))
                ],
              ),
              8.toHeight,
              Row(
                children: [
                  TextWidget(
                    text:
                        '${S.current.publishDate} ${myAdsList[index].publishDate}',
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  Spacer(),
                  TextWidget(
                    text: context
                        .read<SettingsCubit>()
                        .getStatusInfo(myAdsList[index].status!)['text'],
                    color: context
                        .read<SettingsCubit>()
                        .getStatusInfo(myAdsList[index].status!)['color'],
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
                      BlocProvider.of<MyAdsCubit>(context)
                          .setEditIndex(index: index);
                      pageTransition(context,
                          page: EditAdDetailsPage(
                            indexForEdit: index,
                          ));
                    },
                    color: Colors.green,
                    colorText: Colors.white,
                    height: 0.04,
                    width: 0.27,
                    text: 'تعديل',
                    fontSize: 14,
                  ),
                  ButtonWidget(
                    onTap: () {
                      pageTransition(context,
                          page: PropertyDetailsPage(
                            adModel: myAdsList[index],
                          ));
                    },
                    color: Colors.grey,
                    colorText: Colors.white,
                    height: 0.04,
                    width: 0.27,
                    text: 'معاينة',
                    fontSize: 14,
                  ),
                  ButtonWidget(
                    onTap: () {
                      BlocProvider.of<MyAdsCubit>(context)
                          .setEditIndex(index: index);
                      BlocProvider.of<MyAdsCubit>(context).deleteAdProperty();
                    },
                    color: Colors.red,
                    colorText: Colors.white,
                    height: 0.04,
                    width: 0.27,
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

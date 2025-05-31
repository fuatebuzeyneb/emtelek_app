import 'dart:math';

import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/features/add_property_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/features/my_ads/domain/cubit/my_ads_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FurnishedOrUnfurnishedAlertDialog extends StatelessWidget {
  const FurnishedOrUnfurnishedAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PropertyAddAdCubit propertyAddAdCubit =
        BlocProvider.of<PropertyAddAdCubit>(context);

    MyAdsCubit myAdsCubit = BlocProvider.of<MyAdsCubit>(context);
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(),
      backgroundColor: Colors.white,
      content: SizedBox(
          width: context.width * 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ButtonWidget(
                paddingHorizontal: 0,
                paddingVertical: 0,
                width: 0,
                height: 0,
                // text: (index + 1).toString(),
                // colorText: Colors.black38,
                onTap: () {
                  propertyAddAdCubit.changeFurnishStatus(furnishOrNot: true);

                  Navigator.pop(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 0,
                          width: 0,
                          child: Radio(
                            value: true,
                            groupValue: propertyAddAdCubit.furnishStatus,
                            onChanged: (value) {
                              propertyAddAdCubit.changeFurnishStatus(
                                  furnishOrNot: value!);

                              Navigator.pop(context);
                            },
                          ),
                        ),
                        TextWidget(
                          text: S.of(context).Furnished,
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 0,
                // width: 0,
                child: const Divider(
                  color: Colors.black38,
                  thickness: 1,
                ),
              ),
              ButtonWidget(
                paddingHorizontal: 0,
                paddingVertical: 0,
                width: 0,
                height: 0,
                // text: (index + 1).toString(),
                // colorText: Colors.black38,
                onTap: () {
                  propertyAddAdCubit.changeFurnishStatus(furnishOrNot: false);

                  Navigator.pop(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 0,
                          width: 0,
                          child: Radio(
                            value: false,
                            groupValue: propertyAddAdCubit.furnishStatus,
                            onChanged: (value) {
                              propertyAddAdCubit.changeFurnishStatus(
                                  furnishOrNot: value!);

                              Navigator.pop(context);
                            },
                          ),
                        ),
                        TextWidget(
                          text: S.of(context).Unfurnished,
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ]),
                ),
              ),
            ],
          )),
    );
  }
}

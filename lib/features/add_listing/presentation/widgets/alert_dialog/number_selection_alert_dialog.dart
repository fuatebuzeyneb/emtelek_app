import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/features/add_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/features/my_ads/domain/cubit/my_ads_cubit.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberSelectionAlertDialog extends StatelessWidget {
  const NumberSelectionAlertDialog({
    super.key,
    required this.fieldKey,
    required this.startIndex,
    required this.itemCount,
    required this.isEdit,
  });

  final String fieldKey; // المفتاح المستخدم لحفظ القيمة في Cubit
  final int startIndex; // نقطة البداية (0 للغرف، 1 للحمامات)
  final int itemCount; // عدد الخيارات

  final bool isEdit;
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
        height: context.height * 0.75,
        width: context.width * 1,
        child: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            int value = index + startIndex;

            return ButtonWidget(
              paddingHorizontal: 0,
              paddingVertical: 0,
              width: 0,
              height: 0,
              // text: (index + 1).toString(),
              // colorText: Colors.black38,
              onTap: () {
                if (isEdit == false) {
                  propertyAddAdCubit.setPropertyField(fieldKey, value);
                } else {
                  myAdsCubit.updatePropertyField(fieldKey, value);
                }
                Navigator.pop(context);
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 0,
                            width: 0,
                            child: Radio(
                              value: value,
                              groupValue: fieldKey == 'roomCount'
                                  ? (isEdit == false
                                      ? propertyAddAdCubit
                                          .adModel.info!.roomCount
                                      : myAdsCubit.adModel.info!.roomCount)
                                  : fieldKey == 'bathroomCount'
                                      ? (isEdit == false
                                          ? propertyAddAdCubit
                                              .adModel.info!.bathroomCount
                                          : myAdsCubit
                                              .adModel.info!.bathroomCount)
                                      : fieldKey == 'floorNumber'
                                          ? (isEdit == false
                                              ? propertyAddAdCubit
                                                  .adModel.info!.floorNumber
                                              : myAdsCubit
                                                  .adModel.info!.floorNumber)
                                          : fieldKey == 'floorCount'
                                              ? (isEdit == false
                                                  ? propertyAddAdCubit
                                                      .adModel.info!.floorCount
                                                  : myAdsCubit
                                                      .adModel.info!.floorCount)
                                              : fieldKey == 'balconyCount'
                                                  ? (isEdit == false
                                                      ? propertyAddAdCubit
                                                          .adModel
                                                          .info!
                                                          .balconyCount
                                                      : myAdsCubit.adModel.info!
                                                          .balconyCount)
                                                  : 0,
                              onChanged: (value) {
                                if (isEdit == false) {
                                  propertyAddAdCubit.setPropertyField(
                                      fieldKey, value);
                                } else {
                                  myAdsCubit.updatePropertyField(
                                      fieldKey, value);
                                }
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          TextWidget(
                            text: value == 0 ? 'استديو' : '$value',
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 0,
                    // width: 0,
                    child: const Divider(
                      color: Colors.black38,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

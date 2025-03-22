import 'dart:io';

import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/features/add_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/features/add_listing/presentation/pages/finish_page.dart';
import 'package:emtelek/features/add_listing/presentation/widgets/alert_dialog/city_selection_alert_dialog.dart';
import 'package:emtelek/features/add_listing/presentation/widgets/alert_dialog/district_selection_alert_dialog.dart';
import 'package:emtelek/features/add_listing/presentation/widgets/alert_dialog/furnished_or_unfurnished_alert_dialog.dart';

import 'package:emtelek/features/add_listing/presentation/widgets/alert_dialog/number_selection_alert_dialog.dart';
import 'package:emtelek/features/add_listing/presentation/widgets/alert_dialog/seller_type_alert_dialog.dart';
import 'package:emtelek/features/profile/domain/cubit/profile_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/shared/common_pages/image_picker.dart';
import 'package:emtelek/shared/common_pages/select_location.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/models/district-model/district_model.dart';
import 'package:emtelek/shared/widgets/appbar_widget.dart';

import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';

/*

class AddAdDetailsPage extends StatelessWidget {
  const AddAdDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    PropertyAddAdCubit propertyAddAdCubit =
        BlocProvider.of<PropertyAddAdCubit>(context);


    return BlocConsumer<PropertyAddAdCubit, PropertyAddAdState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(





*/
class AddAdDetailsPage extends StatelessWidget {
  const AddAdDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    PropertyAddAdCubit propertyAddAdCubit =
        BlocProvider.of<PropertyAddAdCubit>(context);

    return BlocConsumer<PropertyAddAdCubit, PropertyAddAdState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            shadowColor: Colors.white,
            elevation: 2,
            surfaceTintColor: Colors.white,
            automaticallyImplyLeading: false,
            title: AppBarWidget(
              title: S.of(context).AddYourAd,
              onTap: () {
                propertyAddAdCubit.categoryForAdType = null;
                Navigator.pop(context);
              },
            ),
            backgroundColor: AppColors.appBarBackground,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(height: context.height * 0.02),
                    Container(
                      color: Colors.grey[200],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.info,
                                  color: Colors.black54,
                                  size: context.width * 0.06),
                              8.toWidth,
                              Expanded(
                                child: RichText(
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                        fontFamily: 'Tajawal'),
                                    children: [
                                      TextSpan(
                                        text:
                                            "${S.of(context).AdReviewMessage}\n\n",
                                      ),
                                      TextSpan(
                                        text: S.of(context).AdInfoNote,
                                      ),
                                      TextSpan(
                                        text:
                                            "${S.of(context).AdRejectionReason} \n\n",
                                      ),
                                      TextSpan(
                                        text: S.of(context).QuestionsPrompt,
                                      ),
                                      TextSpan(
                                        text:
                                            S.of(context).PublishingGuidelines,
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            decoration: TextDecoration
                                                .underline), // رابط مرجعي
                                      ),
                                      TextSpan(
                                        text:
                                            S.of(context).DirectContactMessage,
                                      ),
                                      TextSpan(
                                        text: S.of(context).WhatsAppContact,
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            decoration: TextDecoration
                                                .underline), // رابط مرجعي
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    12.toHeight,
                    TextWidget(
                      text: S.of(context).EnterAdDetails,
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    12.toHeight,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                text: settingsCubit.rentCategories.containsKey(
                                        propertyAddAdCubit.categoryForAdType)
                                    ? '${S.of(context).PropertyForRent} --> ${settingsCubit.rentCategories[propertyAddAdCubit.categoryForAdType]} ${S.of(context).ForRent}'
                                    : '${S.of(context).PropertyForSale} --> ${settingsCubit.saleCategories[propertyAddAdCubit.categoryForAdType]} ${S.of(context).ForSale}',
                                fontSize: 14,
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          12.toHeight,
                          TextFieldWidget(
                            paddingVertical: 0,
                            hint: S.of(context).AdTitleHint,
                            onChanged: (value) {
                              propertyAddAdCubit.setPropertyField(
                                  'adModelTitle', value);
                            },
                          ),
                          12.toHeight,
                          ButtonWidget(
                            onTap: () {
                              pageTransition(context,
                                  page: ImagePickerGrid(
                                    maxImages: 12,
                                    forWitchFeature: 1,
                                  ));
                            },
                            height: 0.06,
                            width: 1,
                            color: Colors.white,
                            borderColor: Colors.grey,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.camera,
                                  color: Colors.black38,
                                  size: 26,
                                ),
                                const SizedBox(width: 8),
                                Baseline(
                                  baseline: 20.0,
                                  baselineType: TextBaseline.alphabetic,
                                  child: TextWidget(
                                    text: S.of(context).AddPhotos,
                                    fontSize: 16,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                6.toWidth,
                                propertyAddAdCubit.imagesProperty.isNotEmpty
                                    ? Baseline(
                                        baseline: 20.0,
                                        baselineType: TextBaseline.alphabetic,
                                        child: TextWidget(
                                          text:
                                              "(تم اضافة ${propertyAddAdCubit.imagesProperty.length} صورة)",
                                          fontSize: 16,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                          propertyAddAdCubit.imagesProperty.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                  ),
                                  child: SizedBox(
                                      height: context.height * 0.12,
                                      width: context.width * 1,
                                      child: ListView.builder(
                                        itemCount: propertyAddAdCubit
                                            .imagesProperty.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2, vertical: 4),
                                            child: Container(
                                              height: context.height * 0.12,
                                              width: context.width * 0.25,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.file(
                                                  File(propertyAddAdCubit
                                                      .imagesProperty[index]
                                                      .path),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )),
                                )
                              : SizedBox(),
                          8.toHeight,
                          TextFieldWidget(
                            paddingVertical: 0,
                            hint: S.of(context).PhoneNumber,
                            onChanged: (value) {
                              propertyAddAdCubit.setPropertyField(
                                  'adModelPhone', value);
                            },
                          ),
                          12.toHeight,
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: TextFieldWidget(
                                  paddingVertical: 0,
                                  hint: S.of(context).Price,
                                  onChanged: (value) {
                                    propertyAddAdCubit.setPropertyField(
                                        'adModelPrice', double.tryParse(value));
                                  },
                                  suffixWidget: Padding(
                                    padding: EdgeInsets.only(
                                        top: context.height * 0.02),
                                    child: const TextWidget(
                                      text: 'USD',
                                      fontSize: 16,
                                      color: Colors.black38,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 1,
                                child: ButtonWidget(
                                  onTap: () {},
                                  height: 0.059,
                                  color: Colors.black,
                                  borderColor: Colors.black,
                                  text: "USD",
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          12.toHeight,
                          TextFieldWidget(
                            paddingVertical: 0,
                            hint: S.of(context).TotalArea,
                            onChanged: (value) {
                              propertyAddAdCubit.setPropertyField(
                                  'totalArea', double.tryParse(value));
                            },
                            suffixWidget: Padding(
                              padding: EdgeInsets.only(
                                  top: context.height * 0.016, left: 8),
                              child: const TextWidget(
                                text: ' متر مربع',
                                fontSize: 16,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                          12.toHeight,
                          TextFieldWidget(
                            paddingVertical: 0,
                            onChanged: (value) {
                              propertyAddAdCubit.setPropertyField(
                                  'netOrBuildingArea', double.tryParse(value));
                            },
                            hint: [
                              10,
                              13,
                              16,
                              19
                            ].contains(propertyAddAdCubit.categoryForAdType)
                                ? S.of(context).BuildingAreaOptional
                                : S.of(context).NetAreaOptional,
                            suffixWidget: Padding(
                              padding: EdgeInsets.only(
                                  top: context.height * 0.016, left: 8),
                              child: const TextWidget(
                                text: 'متر مربع',
                                fontSize: 16,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                          12.toHeight,
                          TextFieldWidget(
                            paddingVertical: 8,
                            maxLines: 8,
                            hint: S.of(context).AdDescriptionOptional,
                            onChanged: (value) {
                              propertyAddAdCubit.setPropertyField(
                                  'adModelDescription', value);
                            },
                          ),
                          Visibility(
                            visible: ![11, 17, 7]
                                .contains(propertyAddAdCubit.categoryForAdType),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: ButtonWidget(
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return NumberSelectionAlertDialog(
                                          fieldKey: 'roomCount',
                                          startIndex: 0,
                                          itemCount: 15,
                                          isEdit: false,
                                        );
                                      });
                                },
                                height: 0.06,
                                width: 1,
                                color: Colors.white,
                                borderColor: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        text: propertyAddAdCubit.propertyAdModel
                                                    .roomCount ==
                                                null
                                            ? ''
                                            : propertyAddAdCubit
                                                .propertyAdModel.roomCount
                                                .toString(),
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      propertyAddAdCubit
                                                  .propertyAdModel.roomCount ==
                                              null
                                          ? SizedBox()
                                          : Spacer(),
                                      TextWidget(
                                        text: S.of(context).NumberOfRooms,
                                        fontSize: 16,
                                        color: Colors.black38,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: ![11, 17, 7]
                                .contains(propertyAddAdCubit.categoryForAdType),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: ButtonWidget(
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return NumberSelectionAlertDialog(
                                          fieldKey: 'bathroomCount',
                                          startIndex: 1,
                                          itemCount: 15,
                                          isEdit: false,
                                        );
                                      });
                                },
                                height: 0.06,
                                width: 1,
                                color: Colors.white,
                                borderColor: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        text: propertyAddAdCubit.propertyAdModel
                                                    .bathroomCount ==
                                                null
                                            ? ''
                                            : propertyAddAdCubit
                                                .propertyAdModel.bathroomCount
                                                .toString(),
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      propertyAddAdCubit.propertyAdModel
                                                  .bathroomCount ==
                                              null
                                          ? SizedBox()
                                          : Spacer(),
                                      TextWidget(
                                        text: S.of(context).NumberOfBathrooms,
                                        fontSize: 16,
                                        color: Colors.black38,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: ![
                              11,
                              17,
                            ].contains(propertyAddAdCubit.categoryForAdType),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: ButtonWidget(
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return NumberSelectionAlertDialog(
                                          fieldKey: 'floorNumber',
                                          startIndex: 1,
                                          itemCount: 15,
                                          isEdit: false,
                                        );
                                      });
                                },
                                height: 0.06,
                                width: 1,
                                color: Colors.white,
                                borderColor: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        text: propertyAddAdCubit.propertyAdModel
                                                    .floorNumber ==
                                                null
                                            ? ''
                                            : propertyAddAdCubit
                                                .propertyAdModel.floorNumber
                                                .toString(),
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      propertyAddAdCubit.propertyAdModel
                                                  .floorNumber ==
                                              null
                                          ? SizedBox()
                                          : Spacer(),
                                      TextWidget(
                                        text: S.of(context).FloorNumberOptional,
                                        fontSize: 16,
                                        color: Colors.black38,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: ![
                              11,
                              17,
                            ].contains(propertyAddAdCubit.categoryForAdType),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: ButtonWidget(
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return NumberSelectionAlertDialog(
                                          fieldKey: 'floorCount',
                                          startIndex: 1,
                                          itemCount: 15,
                                          isEdit: false,
                                        );
                                      });
                                },
                                height: 0.06,
                                width: 1,
                                color: Colors.white,
                                borderColor: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        text: propertyAddAdCubit.propertyAdModel
                                                    .floorCount ==
                                                null
                                            ? ''
                                            : propertyAddAdCubit
                                                .propertyAdModel.floorCount
                                                .toString(),
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      propertyAddAdCubit
                                                  .propertyAdModel.floorCount ==
                                              null
                                          ? SizedBox()
                                          : Spacer(),
                                      TextWidget(
                                        text: S.of(context).FloorCountOptional,
                                        fontSize: 16,
                                        color: Colors.black38,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: ![11, 17, 9, 15]
                                .contains(propertyAddAdCubit.categoryForAdType),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: ButtonWidget(
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return NumberSelectionAlertDialog(
                                          fieldKey: 'balconyCount',
                                          startIndex: 1,
                                          itemCount: 15,
                                          isEdit: false,
                                        );
                                      });
                                },
                                height: 0.06,
                                width: 1,
                                color: Colors.white,
                                borderColor: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        text: propertyAddAdCubit.propertyAdModel
                                                    .balconyCount ==
                                                null
                                            ? ''
                                            : propertyAddAdCubit
                                                .propertyAdModel.balconyCount
                                                .toString(),
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      propertyAddAdCubit.propertyAdModel
                                                  .balconyCount ==
                                              null
                                          ? SizedBox()
                                          : Spacer(),
                                      TextWidget(
                                        text: S
                                            .of(context)
                                            .NumberOfBalconiesOptional,
                                        fontSize: 16,
                                        color: Colors.black38,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: ![11, 17, 7]
                                .contains(propertyAddAdCubit.categoryForAdType),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: ButtonWidget(
                                onTap: () async {
                                  final date = await showDatePicker(
                                    helpText: S
                                        .of(context)
                                        .SelectDate, // Can be used as title
                                    cancelText: S.of(context).Close,
                                    confirmText: S.of(context).Select,
                                    context: context,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(3000),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: Theme.of(context)
                                              .colorScheme
                                              .copyWith(
                                                primary: AppColors
                                                    .primary, // Set the select color
                                              ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );

                                  propertyAddAdCubit.setPropertyField(
                                      'constructionDate', date);
                                },
                                height: 0.06,
                                width: 1,
                                color: Colors.white,
                                borderColor: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        text: propertyAddAdCubit.propertyAdModel
                                                    .constructionDate !=
                                                null
                                            ? DateFormat('dd - MM - yyy')
                                                .format(propertyAddAdCubit
                                                    .propertyAdModel
                                                    .constructionDate!)
                                            : '',
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      propertyAddAdCubit.propertyAdModel
                                                  .constructionDate ==
                                              null
                                          ? SizedBox()
                                          : Spacer(),
                                      TextWidget(
                                        text: S
                                            .of(context)
                                            .ConstructionDateOptional,
                                        fontSize: 16,
                                        color: Colors.black38,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: ![11, 17, 9, 15, 10, 16, 13, 19]
                                .contains(propertyAddAdCubit.categoryForAdType),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: ButtonWidget(
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return FurnishedOrUnfurnishedAlertDialog(
                                          isEdit: false,
                                        );
                                      });
                                },
                                height: 0.06,
                                width: 1,
                                color: Colors.white,
                                borderColor: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    children: [
                                      propertyAddAdCubit
                                                  .propertyAdModel.furnished ==
                                              null
                                          ? TextWidget(
                                              text: S
                                                  .of(context)
                                                  .FurnishedOptional,
                                              fontSize: 16,
                                              color: Colors.black38,
                                            )
                                          : TextWidget(
                                              text: propertyAddAdCubit
                                                          .propertyAdModel
                                                          .furnished ==
                                                      true
                                                  ? S.of(context).Furnished
                                                  : S.of(context).Unfurnished,
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          12.toHeight,
                          ButtonWidget(
                            onTap: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return SellerTypeAlertDialog(
                                      isEdit: false,
                                      forWitchType: 1,
                                      // forWitchType: 1,
                                      // onTap: (value) {
                                      //   propertyAddAdCubit.setPropertyField(
                                      //       'adModelSellerType', value);
                                      //   Navigator.pop(context);
                                      // },
                                    );
                                  });
                            },
                            height: 0.06,
                            width: 1,
                            color: Colors.white,
                            borderColor: Colors.grey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  propertyAddAdCubit.propertyAdModel.adModel
                                              .sellerType ==
                                          null
                                      ? TextWidget(
                                          text: S.of(context).PropertyOwner,
                                          fontSize: 16,
                                          color: Colors.black38,
                                        )
                                      : TextWidget(
                                          text: propertyAddAdCubit
                                                      .propertyAdModel
                                                      .adModel
                                                      .sellerType ==
                                                  1
                                              ? S.of(context).Owner
                                              : S.of(context).Agent,
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                ],
                              ),
                            ),
                          ),
                          12.toHeight,
                          BlocBuilder<SettingsCubit, SettingsState>(
                            builder: (context, state) {
                              return ButtonWidget(
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return CitySelectionAlertDialog();
                                      });
                                  propertyAddAdCubit.setPropertyField(
                                      'adModelDistrictId', null);
                                },
                                height: 0.06,
                                width: 1,
                                color: Colors.white,
                                borderColor: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        text: settingsCubit.cityId != null
                                            ? settingsCubit
                                                .globalCities[
                                                    settingsCubit.cityId! - 1]
                                                .cityName
                                            : S.of(context).City,
                                        fontSize: 16,
                                        color: settingsCubit.cityId != null
                                            ? Colors.black
                                            : Colors.black38,
                                        fontWeight: settingsCubit.cityId != null
                                            ? FontWeight.bold
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          12.toHeight,
                          ButtonWidget(
                            onTap: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return DistrictSelectionAlertDialog(
                                      forWitchType: 1,
                                    );
                                  });
                            },
                            height: 0.06,
                            width: 1,
                            color: Colors.white,
                            borderColor: Colors.grey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  TextWidget(
                                    text: propertyAddAdCubit.propertyAdModel
                                                .adModel.districtId !=
                                            null
                                        ? settingsCubit
                                            .globalDistricts[propertyAddAdCubit
                                                    .propertyAdModel
                                                    .adModel
                                                    .districtId! -
                                                1]
                                            .districtName
                                        : S.of(context).Region,
                                    fontSize: 16,
                                    color: propertyAddAdCubit.propertyAdModel
                                                .adModel.districtId !=
                                            null
                                        ? Colors.black
                                        : Colors.black38,
                                    fontWeight: propertyAddAdCubit
                                                .propertyAdModel
                                                .adModel
                                                .districtId !=
                                            null
                                        ? FontWeight.bold
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          12.toHeight,
                          TextFieldWidget(
                            paddingVertical: 8,
                            maxLines: 2,
                            hint: S.of(context).NeighborhoodAndStreetOptional,
                            onChanged: (value) {
                              propertyAddAdCubit.setPropertyField(
                                  'adModelAddress', value);
                            },
                          ),
                          Visibility(
                            visible: ![11, 17, 13, 19]
                                .contains(propertyAddAdCubit.categoryForAdType),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: TextFieldWidget(
                                onChanged: (value) {
                                  propertyAddAdCubit.setPropertyField(
                                      'complexName', value);
                                },
                                paddingVertical: 8,
                                maxLines: 1,
                                hint:
                                    S.of(context).BuildingOrComplexNameOptional,
                              ),
                            ),
                          ),
                          8.toHeight,
                          propertyAddAdCubit.propertyAdModel.adModel.location ==
                                  null
                              ? ButtonWidget(
                                  height: 0.15,
                                  width: 1,
                                  colorText: Colors.black45,
                                  ////  color: Colors.redAccent,
                                  borderColor: Colors.grey,
                                  text: 'اختر الموقع على الخريطة',
                                  onTap: () {
                                    pageTransition(context,
                                        page: const SelectLocation(
                                          isEdit: false,
                                          forWitchFeature: 1,
                                        ));
                                  },
                                )
                              : Stack(
                                  children: [
                                    ButtonWidget(
                                      height: 0.2,
                                      width: 1,
                                      onTap: () {
                                        pageTransition(context,
                                            page: const SelectLocation(
                                              isEdit: false,
                                              forWitchFeature: 1,
                                            ));
                                      },
                                      child: FlutterMap(
                                        key: const Key('map'),
                                        options: MapOptions(
                                          initialCenter: settingsCubit
                                              .parseLatLng(propertyAddAdCubit
                                                  .propertyAdModel
                                                  .adModel
                                                  .location!),
                                        ),
                                        mapController: MapController(),
                                        children: [
                                          TileLayer(
                                            urlTemplate:
                                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                            userAgentPackageName:
                                                'com.example.app',
                                          ),
                                          MarkerLayer(
                                            markers: [
                                              Marker(
                                                point:
                                                    settingsCubit.parseLatLng(
                                                        propertyAddAdCubit
                                                            .propertyAdModel
                                                            .adModel
                                                            .location!),
                                                child: const Icon(
                                                  Icons.location_on,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                                rotate: true,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          pageTransition(context,
                                              page: const SelectLocation(
                                                isEdit: false,
                                                forWitchFeature: 1,
                                              ));
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          height: 30,
                                          width: 40,
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.black,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonWidget(
                  onTap: () {
                    Navigator.pushNamed(context, FinishPage.id);
                  },
                  text: S.of(context).Apply,
                  height: 0.06,
                  width: 1,
                  color: Colors.red,
                  fontSize: 18,
                  colorText: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

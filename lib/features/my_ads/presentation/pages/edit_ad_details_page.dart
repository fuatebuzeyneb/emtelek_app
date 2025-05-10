import 'dart:io';

import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/core/utils/snackbar_utils.dart';
import 'package:emtelek/features/add_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/features/add_listing/presentation/pages/finish_page.dart';
import 'package:emtelek/features/add_listing/presentation/widgets/alert_dialog/city_selection_alert_dialog.dart';
import 'package:emtelek/features/add_listing/presentation/widgets/alert_dialog/district_selection_alert_dialog.dart';
import 'package:emtelek/features/add_listing/presentation/widgets/alert_dialog/furnished_or_unfurnished_alert_dialog.dart';

import 'package:emtelek/features/add_listing/presentation/widgets/alert_dialog/number_selection_alert_dialog.dart';
import 'package:emtelek/features/add_listing/presentation/widgets/alert_dialog/seller_type_alert_dialog.dart';
import 'package:emtelek/features/my_ads/domain/cubit/my_ads_cubit.dart';
import 'package:emtelek/features/profile/domain/cubit/profile_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/shared/common_pages/image_picker.dart';
import 'package:emtelek/shared/common_pages/select_location.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/models/district-model/district_model.dart';
import 'package:emtelek/shared/widgets/appbar_widget.dart';

import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/loading_widget.dart';
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
class EditAdDetailsPage extends StatelessWidget {
  const EditAdDetailsPage({super.key, required this.indexForEdit});
  final int indexForEdit;
  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    PropertyAddAdCubit propertyAddAdCubit =
        BlocProvider.of<PropertyAddAdCubit>(context);

    MyAdsCubit myAdsCubit = BlocProvider.of<MyAdsCubit>(context);

    return BlocConsumer<MyAdsCubit, MyAdsState>(
      listener: (context, state) {
        if (state is PropertyUpdateAdSuccess) {
          myAdsCubit.getMyAds();
          SnackbarUtils.showSnackbar(context, "تم التعديل بنجاح");
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarWidget(
              title: S.of(context).AddYourAd, isHaveBackButton: true),
          body: state is PropertyUpdateAdLoading
              ? const Center(child: LoadingWidget())
              : state is PropertyUpdateAdFailure
                  ? Center(child: Text(state.errorMassage))
                  : Column(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  text:
                                                      S.of(context).AdInfoNote,
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${S.of(context).AdRejectionReason} \n\n",
                                                ),
                                                TextSpan(
                                                  text: S
                                                      .of(context)
                                                      .QuestionsPrompt,
                                                ),
                                                TextSpan(
                                                  text: S
                                                      .of(context)
                                                      .PublishingGuidelines,
                                                  style: const TextStyle(
                                                      color: Colors.blue,
                                                      decoration: TextDecoration
                                                          .underline), // رابط مرجعي
                                                ),
                                                TextSpan(
                                                  text: S
                                                      .of(context)
                                                      .DirectContactMessage,
                                                ),
                                                TextSpan(
                                                  text: S
                                                      .of(context)
                                                      .WhatsAppContact,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        TextWidget(
                                          text: settingsCubit.rentCategories
                                                  .containsKey(myAdsCubit
                                                      .myAds[indexForEdit]
                                                      .categoryId)
                                              ? '${S.of(context).PropertyForRent} --> ${settingsCubit.rentCategories[myAdsCubit.myAds[indexForEdit].categoryId]} ${S.of(context).ForRent}'
                                              : '${S.of(context).PropertyForSale} --> ${settingsCubit.saleCategories[myAdsCubit.myAds[indexForEdit].categoryId]} ${S.of(context).ForSale}',
                                          fontSize: 14,
                                          color: Colors.black,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    12.toHeight,
                                    TextFieldWidget(
                                      initialValue: myAdsCubit
                                          .myAds[indexForEdit].adTitle,
                                      paddingVertical: 0,
                                      hint: S.of(context).AdTitleHint,
                                      onChanged: (value) {
                                        myAdsCubit.updatePropertyField(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.camera,
                                            color: Colors.black38,
                                            size: 26,
                                          ),
                                          const SizedBox(width: 8),
                                          Baseline(
                                            baseline: 20.0,
                                            baselineType:
                                                TextBaseline.alphabetic,
                                            child: TextWidget(
                                              text: S.of(context).AddPhotos,
                                              fontSize: 16,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          6.toWidth,
                                          // propertyAddAdCubit.imagesProperty.isNotEmpty
                                          //     ? Baseline(
                                          //         baseline: 20.0,
                                          //         baselineType: TextBaseline.alphabetic,
                                          //         child: TextWidget(
                                          //           text:
                                          //               "(تم اضافة ${propertyAddAdCubit.imagesProperty.length} صورة)",
                                          //           fontSize: 16,
                                          //           color: Colors.green,
                                          //           fontWeight: FontWeight.bold,
                                          //         ),
                                          //       )
                                          //     : SizedBox(),
                                        ],
                                      ),
                                    ),
                                    // propertyAddAdCubit.imagesProperty.isNotEmpty
                                    //     ? Padding(
                                    //         padding: const EdgeInsets.only(
                                    //           top: 8,
                                    //         ),
                                    //         child: SizedBox(
                                    //             height: context.height * 0.12,
                                    //             width: context.width * 1,
                                    //             child: ListView.builder(
                                    //               itemCount: propertyAddAdCubit
                                    //                   .imagesProperty.length,
                                    //               scrollDirection: Axis.horizontal,
                                    //               itemBuilder:
                                    //                   (BuildContext context, int index) {
                                    //                 return Padding(
                                    //                   padding: const EdgeInsets.symmetric(
                                    //                       horizontal: 2, vertical: 4),
                                    //                   child: Container(
                                    //                     height: context.height * 0.12,
                                    //                     width: context.width * 0.25,
                                    //                     decoration: BoxDecoration(
                                    //                       border: Border.all(
                                    //                         color: Colors.grey,
                                    //                         width: 1,
                                    //                       ),
                                    //                       borderRadius:
                                    //                           BorderRadius.circular(8),
                                    //                     ),
                                    //                     child: ClipRRect(
                                    //                       borderRadius:
                                    //                           BorderRadius.circular(8),
                                    //                       child: Image.file(
                                    //                         File(propertyAddAdCubit
                                    //                             .imagesProperty[index]
                                    //                             .path),
                                    //                         fit: BoxFit.cover,
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                 );
                                    //               },
                                    //             )),
                                    //       )
                                    //     : SizedBox(),
                                    8.toHeight,
                                    TextFieldWidget(
                                      initialValue: myAdsCubit
                                          .myAds[indexForEdit]
                                          .client!
                                          .phoneNumber,
                                      paddingVertical: 0,
                                      hint: S.of(context).PhoneNumber,
                                      onChanged: (value) {
                                        myAdsCubit.updatePropertyField(
                                            'adModelPhone', value);
                                      },
                                    ),
                                    12.toHeight,
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: TextFieldWidget(
                                            initialValue: myAdsCubit
                                                .myAds[indexForEdit].price
                                                .toString(),
                                            paddingVertical: 0,
                                            hint: S.of(context).Price,
                                            onChanged: (value) {
                                              myAdsCubit.updatePropertyField(
                                                  'adModelPrice',
                                                  double.tryParse(value));
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
                                      initialValue: myAdsCubit
                                          .myAds[indexForEdit].info!.totalArea
                                          .toString(),
                                      paddingVertical: 0,
                                      hint: S.of(context).TotalArea,
                                      onChanged: (value) {
                                        myAdsCubit.updatePropertyField(
                                            'totalArea',
                                            double.tryParse(value));
                                      },
                                      suffixWidget: Padding(
                                        padding: EdgeInsets.only(
                                            top: context.height * 0.016,
                                            left: 8),
                                        child: const TextWidget(
                                          text: ' متر مربع',
                                          fontSize: 16,
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ),
                                    12.toHeight,
                                    TextFieldWidget(
                                      initialValue: myAdsCubit
                                          .myAds[indexForEdit].info!.netArea
                                          .toString(),
                                      paddingVertical: 0,
                                      onChanged: (value) {
                                        myAdsCubit.updatePropertyField(
                                            'netOrBuildingArea',
                                            double.tryParse(value));
                                      },
                                      hint: [10, 13, 16, 19].contains(myAdsCubit
                                              .myAds[indexForEdit].categoryId)
                                          ? S.of(context).BuildingAreaOptional
                                          : S.of(context).NetAreaOptional,
                                      suffixWidget: Padding(
                                        padding: EdgeInsets.only(
                                            top: context.height * 0.016,
                                            left: 8),
                                        child: const TextWidget(
                                          text: 'متر مربع',
                                          fontSize: 16,
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ),
                                    12.toHeight,
                                    TextFieldWidget(
                                      initialValue: myAdsCubit
                                          .myAds[indexForEdit].description,
                                      paddingVertical: 8,
                                      maxLines: 8,
                                      hint: S.of(context).AdDescriptionOptional,
                                      onChanged: (value) {
                                        myAdsCubit.updatePropertyField(
                                            'adModelDescription', value);
                                      },
                                    ),
                                    Visibility(
                                      visible: ![11, 17, 7].contains(myAdsCubit
                                          .myAds[indexForEdit].categoryId),
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
                                                    isEdit: true,
                                                    startIndex: 0,
                                                    itemCount: 15,
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
                                                  text: myAdsCubit.adModel.info!
                                                              .roomCount ==
                                                          null
                                                      ? '99'
                                                      : myAdsCubit.adModel.info!
                                                          .roomCount
                                                          .toString(),
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                Spacer(),
                                                TextWidget(
                                                  text: S
                                                      .of(context)
                                                      .NumberOfRooms,
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
                                      visible: ![11, 17, 7].contains(myAdsCubit
                                          .myAds[indexForEdit].categoryId),
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
                                                    isEdit: true,
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
                                                  text: myAdsCubit.adModel.info!
                                                              .bathroomCount !=
                                                          null
                                                      ? myAdsCubit.adModel.info!
                                                          .bathroomCount
                                                          .toString()
                                                      : myAdsCubit
                                                                  .myAds[
                                                                      indexForEdit]
                                                                  .info!
                                                                  .bathroomCount ==
                                                              null
                                                          ? ''
                                                          : myAdsCubit
                                                              .myAds[
                                                                  indexForEdit]
                                                              .info!
                                                              .bathroomCount
                                                              .toString(),
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                myAdsCubit.adModel.info!
                                                            .bathroomCount ==
                                                        null
                                                    ? SizedBox()
                                                    : Spacer(),
                                                TextWidget(
                                                  text: S
                                                      .of(context)
                                                      .NumberOfBathrooms,
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
                                      ].contains(myAdsCubit
                                          .myAds[indexForEdit].categoryId),
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
                                                    isEdit: true,
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
                                                  text: myAdsCubit.adModel.info!
                                                              .floorNumber !=
                                                          null
                                                      ? myAdsCubit.adModel.info!
                                                          .floorNumber
                                                          .toString()
                                                      : myAdsCubit
                                                                  .myAds[
                                                                      indexForEdit]
                                                                  .info!
                                                                  .floorNumber ==
                                                              null
                                                          ? ''
                                                          : myAdsCubit
                                                              .myAds[
                                                                  indexForEdit]
                                                              .info!
                                                              .floorNumber
                                                              .toString(),
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                myAdsCubit.adModel.info!
                                                            .floorNumber ==
                                                        null
                                                    ? SizedBox()
                                                    : Spacer(),
                                                TextWidget(
                                                  text: S
                                                      .of(context)
                                                      .FloorNumberOptional,
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
                                      ].contains(myAdsCubit
                                          .myAds[indexForEdit].categoryId),
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
                                                    isEdit: true,
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
                                                  text: myAdsCubit.adModel.info!
                                                              .floorCount !=
                                                          null
                                                      ? myAdsCubit.adModel.info!
                                                          .floorCount
                                                          .toString()
                                                      : myAdsCubit
                                                                  .myAds[
                                                                      indexForEdit]
                                                                  .info!
                                                                  .floorCount ==
                                                              null
                                                          ? ''
                                                          : myAdsCubit
                                                              .myAds[
                                                                  indexForEdit]
                                                              .info!
                                                              .floorCount
                                                              .toString(),
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                myAdsCubit.adModel.info!
                                                            .floorCount ==
                                                        null
                                                    ? SizedBox()
                                                    : Spacer(),
                                                TextWidget(
                                                  text: S
                                                      .of(context)
                                                      .FloorCountOptional,
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
                                      visible: ![11, 17, 9, 15].contains(
                                          myAdsCubit
                                              .myAds[indexForEdit].categoryId),
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
                                                    isEdit: true,
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
                                                  text: myAdsCubit.adModel.info!
                                                              .balconyCount !=
                                                          null
                                                      ? myAdsCubit.adModel.info!
                                                          .balconyCount
                                                          .toString()
                                                      : myAdsCubit
                                                                  .myAds[
                                                                      indexForEdit]
                                                                  .info!
                                                                  .balconyCount ==
                                                              null
                                                          ? ''
                                                          : myAdsCubit
                                                              .myAds[
                                                                  indexForEdit]
                                                              .info!
                                                              .balconyCount
                                                              .toString(),
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                myAdsCubit.adModel.info!
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
                                      visible: ![11, 17, 7].contains(myAdsCubit
                                          .myAds[indexForEdit].categoryId),
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
                                              builder: (BuildContext context,
                                                  Widget? child) {
                                                return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    colorScheme:
                                                        Theme.of(context)
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

                                            date != null
                                                ? myAdsCubit
                                                    .updatePropertyField(
                                                        'constructionDate',
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(date))
                                                : null;
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
                                                  text:
                                                      '${myAdsCubit.adModel.info!.constructionDate}' ??
                                                          '',
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                myAdsCubit.adModel.info!
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
                                          .contains(myAdsCubit
                                              .myAds[indexForEdit].categoryId),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: ButtonWidget(
                                          onTap: () {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return FurnishedOrUnfurnishedAlertDialog(
                                                    isEdit: true,
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
                                                // myAdsCubit.adModel
                                                //               .balconyCount !=
                                                //           null
                                                //       ? myAdsCubit
                                                //           .adsModel.balconyCount
                                                //           .toString()
                                                //       : myAdsCubit
                                                //                   .myAds[
                                                //                       indexForEdit]
                                                //                   .balconyCount ==
                                                //               null
                                                //           ? ''
                                                // : myAdsCubit
                                                //     .myAds[
                                                //         indexForEdit]
                                                //               .balconyCount
                                                //               .toString(),
                                                myAdsCubit.myAds[indexForEdit]
                                                            .info!.furnish ==
                                                        null
                                                    ? TextWidget(
                                                        text: S
                                                            .of(context)
                                                            .FurnishedOptional,
                                                        fontSize: 16,
                                                        color: Colors.black38,
                                                      )
                                                    : TextWidget(
                                                        text: myAdsCubit
                                                                    .adModel
                                                                    .info!
                                                                    .furnish !=
                                                                null
                                                            ? myAdsCubit
                                                                        .adModel
                                                                        .info!
                                                                        .furnish ==
                                                                    'true'
                                                                ? S
                                                                    .of(context)
                                                                    .Furnished
                                                                : S
                                                                    .of(context)
                                                                    .Unfurnished
                                                            : myAdsCubit
                                                                        .myAds[
                                                                            indexForEdit]
                                                                        .info!
                                                                        .furnish ==
                                                                    'true'
                                                                ? S
                                                                    .of(context)
                                                                    .Furnished
                                                                : S
                                                                    .of(context)
                                                                    .Unfurnished,
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                isEdit: true,
                                                forWitchType: 1,
                                                // forWitchType: 1,
                                                // onTap: (value) {
                                                //            myAdsCubit.updatePropertyField(
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Row(
                                          children: [
                                            // myAdsCubit.adModel

                                            //             .sellerType ==
                                            //         null
                                            // ? TextWidget(
                                            //     text: S.of(context).PropertyOwner,
                                            //     fontSize: 16,
                                            //     color: Colors.black38,
                                            //   )
                                            // :
                                            TextWidget(
                                              text: myAdsCubit
                                                          .adModel.sellerType ==
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
                                    // 12.toHeight,
                                    // BlocBuilder<SettingsCubit, SettingsState>(
                                    //   builder: (context, state) {
                                    //     return ButtonWidget(
                                    //       onTap: () {
                                    //         showDialog(
                                    //             barrierDismissible: false,
                                    //             context: context,
                                    //             builder: (context) {
                                    //               return CitySelectionAlertDialog();
                                    //             });
                                    //                  myAdsCubit.updatePropertyField(
                                    //             'adModelDistrictId', null);
                                    //       },
                                    //       height: 0.06,
                                    //       width: 1,
                                    //       color: Colors.white,
                                    //       borderColor: Colors.grey,
                                    //       child: Padding(
                                    //         padding: const EdgeInsets.symmetric(
                                    //             horizontal: 12),
                                    //         child: Row(
                                    //           children: [
                                    //             TextWidget(
                                    //               text: settingsCubit.cityId != null
                                    //                   ? settingsCubit
                                    //                       .globalCities[
                                    //                           settingsCubit.cityId! - 1]
                                    //                       .cityName
                                    //                   : S.of(context).City,
                                    //               fontSize: 16,
                                    //               color: settingsCubit.cityId != null
                                    //                   ? Colors.black
                                    //                   : Colors.black38,
                                    //               fontWeight: settingsCubit.cityId != null
                                    //                   ? FontWeight.bold
                                    //                   : null,
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     );
                                    //   },
                                    // ),
                                    // 12.toHeight,
                                    // ButtonWidget(
                                    //   onTap: () {
                                    //     showDialog(
                                    //         barrierDismissible: false,
                                    //         context: context,
                                    //         builder: (context) {
                                    //           return DistrictSelectionAlertDialog(
                                    //             forWitchType: 1,
                                    //           );
                                    //         });
                                    //   },
                                    //   height: 0.06,
                                    //   width: 1,
                                    //   color: Colors.white,
                                    //   borderColor: Colors.grey,
                                    //   child: Padding(
                                    //     padding:
                                    //         const EdgeInsets.symmetric(horizontal: 12),
                                    //     child: Row(
                                    //       children: [
                                    //         TextWidget(
                                    //           text:
                                    //            propertyAddAdCubit.propertyAdModel
                                    //                       .adModel.districtId !=
                                    //                   null
                                    //               ? settingsCubit
                                    //                   .globalDistricts[propertyAddAdCubit
                                    //                           .propertyAdModel
                                    //                           .adModel
                                    //                           .districtId! -
                                    //                       1]
                                    //                   .districtName
                                    //               : S.of(context).Region,
                                    //           fontSize: 16,
                                    //           color: propertyAddAdCubit.propertyAdModel
                                    //                       .adModel.districtId !=
                                    //                   null
                                    //               ? Colors.black
                                    //               : Colors.black38,
                                    //           fontWeight: propertyAddAdCubit
                                    //                       .propertyAdModel
                                    //                       .adModel
                                    //                       .districtId !=
                                    //                   null
                                    //               ? FontWeight.bold
                                    //               : null,
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    12.toHeight,
                                    TextFieldWidget(
                                      initialValue: myAdsCubit
                                          .myAds[indexForEdit].info!.address,
                                      paddingVertical: 8,
                                      maxLines: 2,
                                      hint: S
                                          .of(context)
                                          .NeighborhoodAndStreetOptional,
                                      onChanged: (value) {
                                        myAdsCubit.updatePropertyField(
                                            'adModelAddress', value);
                                      },
                                    ),
                                    Visibility(
                                      visible: ![11, 17, 13, 19].contains(
                                          myAdsCubit
                                              .myAds[indexForEdit].categoryId),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: TextFieldWidget(
                                          initialValue: myAdsCubit
                                              .myAds[indexForEdit]
                                              .info!
                                              .complexName,
                                          onChanged: (value) {
                                            myAdsCubit.updatePropertyField(
                                                'complexName', value);
                                          },
                                          paddingVertical: 8,
                                          maxLines: 1,
                                          hint: S
                                              .of(context)
                                              .BuildingOrComplexNameOptional,
                                        ),
                                      ),
                                    ),
                                    8.toHeight,
                                    // myAdsCubit.adModel
                                    //                           .location ==
                                    //         null
                                    //     ? ButtonWidget(
                                    //         height: 0.15,
                                    //         width: 1,
                                    //         colorText: Colors.black45,
                                    //         ////  color: Colors.redAccent,
                                    //         borderColor: Colors.grey,
                                    //         text: 'اختر الموقع على الخريطة',
                                    //         onTap: () {
                                    //           pageTransition(context,
                                    //               page: const SelectLocation(
                                    //                 forWitchFeature: 1,
                                    //               ));
                                    //         },
                                    //       )
                                    //     :

                                    Stack(
                                      children: [
                                        ButtonWidget(
                                          height: 0.2,
                                          width: 1,
                                          onTap: () {
                                            pageTransition(context,
                                                page: const SelectLocation(
                                                  isEdit: true,
                                                  forWitchFeature: 1,
                                                ));
                                          },
                                          child: FlutterMap(
                                            key: const Key('map'),
                                            options: MapOptions(
                                              initialCenter: settingsCubit
                                                  .parseLatLng(myAdsCubit
                                                      .myAds[indexForEdit]
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
                                                    point: settingsCubit
                                                        .parseLatLng(myAdsCubit
                                                            .myAds[indexForEdit]
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
                                                    forWitchFeature: 1,
                                                    isEdit: true,
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
                              myAdsCubit.updateAdPropertyFunc();
                              //Navigator.pushNamed(context, FinishPage.id);
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

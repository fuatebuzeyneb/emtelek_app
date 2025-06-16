import 'dart:io';

import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/core/utils/snackbar_utils.dart';
import 'package:emtelek/features/add_property_listing/data/models/add_property_ad_request_model.dart';
import 'package:emtelek/features/add_property_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/features/add_property_listing/presentation/pages/finish_page.dart';
import 'package:emtelek/features/add_property_listing/presentation/widgets/alert_dialog/ad_features_alert_dialog.dart';
import 'package:emtelek/features/add_property_listing/presentation/widgets/alert_dialog/city_selection_alert_dialog.dart';
import 'package:emtelek/features/add_property_listing/presentation/widgets/alert_dialog/currency_selection_alert_dialog.dart';
import 'package:emtelek/features/add_property_listing/presentation/widgets/alert_dialog/district_selection_alert_dialog.dart';
import 'package:emtelek/features/add_property_listing/presentation/widgets/alert_dialog/furnished_or_unfurnished_alert_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emtelek/features/add_property_listing/presentation/widgets/alert_dialog/number_selection_alert_dialog.dart';
import 'package:emtelek/features/add_property_listing/presentation/widgets/alert_dialog/seller_type_alert_dialog.dart';
import 'package:emtelek/features/home/data/models/property_model.dart';
import 'package:emtelek/features/home/presentation/widgets/ad_card_home_widget.dart';
import 'package:emtelek/features/my_ads/domain/cubit/my_ads_cubit.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/features/profile/domain/cubit/profile_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/shared/common_pages/image_picker.dart';
import 'package:emtelek/shared/common_pages/select_location.dart';
import 'package:emtelek/shared/cubits/cubit/add_ad_global_cubit.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/helper/founctions/formatter.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

import 'package:emtelek/shared/widgets/alert_dialog_widget.dart';
import 'package:emtelek/shared/widgets/appbar_widget.dart';
import 'package:emtelek/shared/widgets/bottom_nav_bar.dart';

import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

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
class AddOrEditAdDetailsPage extends StatefulWidget {
  final bool itIsEdit;
  final int? indexForEdit;

  const AddOrEditAdDetailsPage({
    super.key,
    required this.itIsEdit,
    this.indexForEdit,
  });

  @override
  State<AddOrEditAdDetailsPage> createState() => _AddOrEditAdDetailsPageState();
}

class _AddOrEditAdDetailsPageState extends State<AddOrEditAdDetailsPage> {
  final titleAdController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final priceController = TextEditingController();
  final totalAreaController = TextEditingController();
  final netAreaController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  final complexNameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();
  final FocusNode totalAreaFocusNode = FocusNode();
  final FocusNode netAreaFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode complexNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _initializeAdData(); // ← استدعِ الدالة غير المتزامنة هنا
  }

  Future<void> _initializeAdData() async {
    if (widget.itIsEdit) {
      final data = context.read<MyAdsCubit>().myAdsX[widget.indexForEdit!];
      PropertyAddAdCubit propertyAddAdCubit =
          BlocProvider.of<PropertyAddAdCubit>(context);
      AddAdGlobalCubit addAdGlobalCubit = context.read<AddAdGlobalCubit>();

      if (data.property.features != null &&
          data.property.features!.isNotEmpty) {
        propertyAddAdCubit.getFeatures();
      }

      titleAdController.text = data.property.adTitle;
      phoneNumberController.text =
          data.property.data.client.phoneNumber.toString();
      priceController.text = data.property.price.toString();
      totalAreaController.text = data.property.data.info.totalArea.toString();
      netAreaController.text = data.property.data.info.netArea.toString();
      descriptionController.text = data.property.description.toString();
      addressController.text = data.property.data.info.address.toString();
      complexNameController.text =
          data.property.data.info.complexName.toString();
      propertyAddAdCubit.categoryForAdType = data.property.categoryId;

      addAdGlobalCubit.districtId = data.property.districtId;
      addAdGlobalCubit.cityId = data.property.data.city.cityId;
      addAdGlobalCubit.currencyId = data.property.currency;
      addAdGlobalCubit.sellerType = data.property.sellerType;
      addAdGlobalCubit.location = data.property.location;
      propertyAddAdCubit.roomCount = data.property.data.info.roomCount;
      propertyAddAdCubit.bathroomCount = data.property.data.info.bathroomCount;
      propertyAddAdCubit.floorCount = data.property.data.info.floorCount;
      propertyAddAdCubit.floorNumber = data.property.data.info.floorNumber;
      propertyAddAdCubit.furnishStatus =
          data.property.data.info.furnish == 'yes' ? true : false;

      propertyAddAdCubit.constructionDate =
          data.property.data.info.constructionDate == null
              ? null
              : DateTime.tryParse(data.property.data.info.constructionDate);

      propertyAddAdCubit.featuresListId =
          data.property.features?.map((e) => e.featureId).toList() ?? [];

      propertyAddAdCubit.mainImage = await urlToXFile(data.property.mainImage);
      propertyAddAdCubit.imagesProperty = await Future.wait(
        data.property.images.map((e) => urlToXFile(e.attachmentName)),
      );
    }
  }

  @override
  void dispose() {
    titleAdController.dispose();
    phoneNumberController.dispose();
    priceController.dispose();
    totalAreaController.dispose();
    netAreaController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    complexNameController.dispose();
    focusNode.dispose();
    titleFocusNode.dispose();
    phoneFocusNode.dispose();
    priceFocusNode.dispose();
    totalAreaFocusNode.dispose();
    netAreaFocusNode.dispose();
    descriptionFocusNode.dispose();
    addressFocusNode.dispose();
    complexNameFocusNode.dispose();
    super.dispose();
  }

  Future<XFile> urlToXFile(String imageFileName) async {
    final fullUrl = '${EndPoints.adImageUrl}$imageFileName';

    final response = await http.get(Uri.parse(fullUrl));

    if (response.statusCode != 200) {
      throw Exception('❌ Failed to download image: $fullUrl');
    }

    if (response.bodyBytes.isEmpty) {
      throw Exception('❌ Downloaded image is empty: $fullUrl');
    }

    final contentType = response.headers['content-type'];
    if (contentType != 'image/webp') {
      throw Exception(
          '❌ Invalid image format: expected image/webp, got $contentType');
    }

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$imageFileName');
    await file.writeAsBytes(response.bodyBytes);

    return XFile(file.path);
  }

  void _onButtonPressed() {
    // إزالة التركيز من التكست
    focusNode.unfocus();

    // إلغاء أي محاولة تلقائية للسكرول
    _scrollController.jumpTo(_scrollController.offset);

    // تابع إجراءات الزر
    print("Button Pressed");
  }

  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    PropertyAddAdCubit propertyAddAdCubit =
        BlocProvider.of<PropertyAddAdCubit>(context);
    AddAdGlobalCubit addAdGlobalCubit = context.read<AddAdGlobalCubit>();
    return BlocConsumer<PropertyAddAdCubit, PropertyAddAdState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBarWidget(
            title: S.of(context).AddYourAd,
            isHaveBackButton: true,
            onTap: () {
              // showDialog<void>(
              //   context: context,
              //   barrierDismissible: false, // user must tap button!
              //   builder: (BuildContext context) {
              //     return AlertDialogWidget(
              //       title: 'تنبيه!!',
              //       subtitle: 'سوف يتم حذف كل البيانات المدخلة',
              //       widget: Icon(
              //         Icons.info,
              //         color: Colors.red,
              //       ),
              //       onYes: () {
              //         Navigator.pop(context);
              //         propertyAddAdCubit.adModel = AdModel(
              //           price: null,
              //           location: null,
              //           description: '',
              //           currency: 'USD',
              //           clientId:
              //               getIt<CacheHelper>().getData(key: 'clientId')!,
              //           sellerType: null,
              //           categoryId: null,
              //           token:
              //               getIt<CacheHelper>().getDataString(key: 'token')!,
              //           adId: null,
              //           adTitle: null,
              //           // publishDate: null,
              //           featureIds: [],
              //           client: ClientModel(
              //             clientId: null,
              //             phoneNumber: null,
              //             email: null,
              //             firstName: null,
              //             lastName: null,
              //             subscriptionDate: null,
              //             image: null,
              //             verified: null,
              //           ),
              //           district: DistrictModel(districtId: null),
              //           info: AdInfoModel(
              //               totalArea: null,
              //               netArea: '',
              //               roomCount: null,
              //               floorNumber: null,
              //               floorCount: null,
              //               bathroomCount: null,
              //               furnish: null,
              //               constructionDate: null,
              //               address: null,
              //               balconyCount: null,
              //               complexName: null),
              //         );

              //         pageTransition(context, page: BottomNavBar());
              //       },
              //       onNo: () {
              //         Navigator.pop(context);
              //       },
              //     );
              //   },
              // );
              addAdGlobalCubit.cityId = null;
              addAdGlobalCubit.districtId = null;
              addAdGlobalCubit.sellerType = null;
              propertyAddAdCubit.roomCount = null;
              propertyAddAdCubit.bathroomCount = null;
              propertyAddAdCubit.categoryForAdType = null;
              addAdGlobalCubit.location = null;
              propertyAddAdCubit.floorCount = null;
              propertyAddAdCubit.floorNumber = null;
              propertyAddAdCubit.balconyCount = null;
              propertyAddAdCubit.featuresListId.clear();
              propertyAddAdCubit.constructionDate = null;
              propertyAddAdCubit.imagesProperty.clear();
              propertyAddAdCubit.mainImage = null;

              Navigator.pop(context);
            },
          ),
          body: GestureDetector(
            onTap: () {
              focusNode.unfocus();
            },
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
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
                                  text: settingsCubit.rentCategories
                                          .containsKey(propertyAddAdCubit
                                              .categoryForAdType)
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
                              focusNode: titleFocusNode,
                              controller: titleAdController,
                              paddingVertical: 0,
                              hint: S.of(context).AdTitleHint,
                              // onChanged: (value) {
                              //   propertyAddAdCubit.setPropertyField(
                              //       'adModelTitle', value);
                              // },
                            ),
                            12.toHeight,
                            ButtonWidget(
                              onTap: () {
                                pageTransition(context,
                                    page: ImagePickerGrid(
                                      maxImages: 12,
                                      forWitchFeature: 1,
                                      initialImages:
                                          propertyAddAdCubit.imagesProperty,
                                      initialMainImage:
                                          propertyAddAdCubit.mainImage,
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
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2,
                                                      vertical: 4),
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
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.file(
                                                      File(propertyAddAdCubit
                                                          .imagesProperty[index]
                                                          .path),
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                            );
                                          },
                                        )),
                                  )
                                : SizedBox(),

                            // widget.itIsEdit == true &&
                            //         context
                            //             .read<MyAdsCubit>()
                            //             .myAdsX[widget.indexForEdit!]
                            //             .property
                            //             .images
                            //             .isNotEmpty
                            //     ? Padding(
                            //         padding: const EdgeInsets.only(
                            //           top: 8,
                            //         ),
                            //         child: SizedBox(
                            //             height: context.height * 0.12,
                            //             width: context.width * 1,
                            //             child: ListView.builder(
                            //               itemCount: context
                            //                   .read<MyAdsCubit>()
                            //                   .myAdsX[widget.indexForEdit!]
                            //                   .property
                            //                   .images
                            //                   .length,
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
                            //                         borderRadius:
                            //                             BorderRadius.circular(8),
                            //                         child: Image.network(
                            //                           "${EndPoints.adImageUrl}${context.read<MyAdsCubit>().myAdsX[widget.indexForEdit!].property.images[index].attachmentName}",
                            //                           fit: BoxFit.cover,
                            //                         )),
                            //                   ),
                            //                 );
                            //               },
                            //             )),
                            //       )
                            //     : SizedBox(),
                            8.toHeight,
                            TextFieldWidget(
                              focusNode: phoneFocusNode,
                              controller: phoneNumberController,
                              paddingVertical: 0,
                              hint: S.of(context).PhoneNumber,
                              // onChanged: (value) {
                              //   propertyAddAdCubit.setPropertyField(
                              //       'adModelPhone', value);
                              // },
                            ),
                            12.toHeight,
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: TextFieldWidget(
                                    focusNode: priceFocusNode,
                                    paddingVertical: 0,
                                    hint: S.of(context).Price,
                                    controller: priceController,
                                    // onChanged: (value) {
                                    //   propertyAddAdCubit.setPropertyField(
                                    //       'adModelPrice', value);

                                    // },
                                    suffixWidget: BlocBuilder<AddAdGlobalCubit,
                                        AddAdGlobalState>(
                                      builder: (context, state) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              top: context.height * 0.02),
                                          child: TextWidget(
                                            text:
                                                '${addAdGlobalCubit.currencyId}',
                                            fontSize: 16,
                                            color: Colors.black38,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                BlocBuilder<AddAdGlobalCubit, AddAdGlobalState>(
                                  builder: (context, state) {
                                    return Expanded(
                                      flex: 1,
                                      child: ButtonWidget(
                                        onTap: () {
                                          focusNode.unfocus();
                                          titleFocusNode.unfocus();
                                          descriptionFocusNode.unfocus();
                                          phoneFocusNode.unfocus();
                                          priceFocusNode.unfocus();
                                          totalAreaFocusNode.unfocus();
                                          netAreaFocusNode.unfocus();
                                          addressFocusNode.unfocus();
                                          complexNameFocusNode.unfocus();
                                          _scrollController
                                              .jumpTo(_scrollController.offset);
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return CurrencySelectionAlertDialog();
                                            },
                                          );
                                        },
                                        height: 0.059,
                                        color: Colors.black,
                                        borderColor: Colors.black,
                                        text: addAdGlobalCubit.currencyId,
                                        fontSize: 16,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            // Visibility(
                            //   visible: settingsCubit.sypRate != null &&
                            //       settingsCubit.tryRate != null ,
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(top: 8.0),
                            //     child: Column(
                            //       children: [
                            //         Row(
                            //           children: [
                            //             TextWidget(
                            //               text:
                            //                   'السعر بالليره السوري:${(double.tryParse(propertyAddAdCubit.adModel.price ?? '0') ?? 0) * (settingsCubit.sypRate ?? 0.0) ?? 0.0} ل.س',
                            //             ),
                            //           ],
                            //         ),
                            //         Row(
                            //           children: [
                            //             TextWidget(
                            //               text:
                            //                   'السعر بالليره التركية: ${(double.tryParse(propertyAddAdCubit.adModel.price ?? '0') ?? 0) * (settingsCubit.tryRate ?? 0.0) ?? 0.0} ل.ت',
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            12.toHeight,
                            TextFieldWidget(
                              focusNode: totalAreaFocusNode,
                              controller: totalAreaController,
                              paddingVertical: 0,
                              hint: S.of(context).TotalArea,
                              // onChanged: (value) {
                              //   propertyAddAdCubit.setPropertyField(
                              //       'totalArea', value);
                              // },
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
                              focusNode: netAreaFocusNode,
                              paddingVertical: 0,
                              controller: netAreaController,
                              // onChanged: (value) {
                              //   propertyAddAdCubit.setPropertyField(
                              //       'netOrBuildingArea', value);
                              // },
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
                              focusNode: descriptionFocusNode,
                              paddingVertical: 8,
                              maxLines: 8,
                              hint: S.of(context).AdDescriptionOptional,
                              controller: descriptionController,
                              // onChanged: (value) {
                              //   propertyAddAdCubit.setPropertyField(
                              //       'adModelDescription', value);
                              // },
                            ),
                            Visibility(
                              visible: ![
                                11,
                                17,
                                7
                              ].contains(propertyAddAdCubit.categoryForAdType),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: ButtonWidget(
                                  onTap: () {
                                    showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (context) {
                                          focusNode.unfocus();
                                          titleFocusNode.unfocus();
                                          descriptionFocusNode.unfocus();
                                          phoneFocusNode.unfocus();
                                          priceFocusNode.unfocus();
                                          totalAreaFocusNode.unfocus();
                                          netAreaFocusNode.unfocus();
                                          addressFocusNode.unfocus();
                                          complexNameFocusNode.unfocus();
                                          _scrollController
                                              .jumpTo(_scrollController.offset);
                                          return NumberSelectionAlertDialog(
                                            fieldKey: 'roomCount',
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
                                          text: propertyAddAdCubit.roomCount ==
                                                  null
                                              ? ''
                                              : propertyAddAdCubit.roomCount
                                                  .toString(),
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        propertyAddAdCubit.roomCount == null
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
                              visible: ![
                                11,
                                17,
                                7
                              ].contains(propertyAddAdCubit.categoryForAdType),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: ButtonWidget(
                                  onTap: () {
                                    focusNode.unfocus();
                                    titleFocusNode.unfocus();
                                    descriptionFocusNode.unfocus();
                                    phoneFocusNode.unfocus();
                                    priceFocusNode.unfocus();
                                    totalAreaFocusNode.unfocus();
                                    netAreaFocusNode.unfocus();
                                    addressFocusNode.unfocus();
                                    complexNameFocusNode.unfocus();
                                    _scrollController
                                        .jumpTo(_scrollController.offset);
                                    showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (context) {
                                          return NumberSelectionAlertDialog(
                                            fieldKey: 'bathroomCount',
                                            startIndex: 1,
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
                                          text: propertyAddAdCubit
                                                      .bathroomCount ==
                                                  null
                                              ? ''
                                              : propertyAddAdCubit.bathroomCount
                                                  .toString(),
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        propertyAddAdCubit.bathroomCount == null
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
                                    focusNode.unfocus();
                                    titleFocusNode.unfocus();
                                    descriptionFocusNode.unfocus();
                                    phoneFocusNode.unfocus();
                                    priceFocusNode.unfocus();
                                    totalAreaFocusNode.unfocus();
                                    netAreaFocusNode.unfocus();
                                    addressFocusNode.unfocus();
                                    complexNameFocusNode.unfocus();
                                    _scrollController
                                        .jumpTo(_scrollController.offset);
                                    showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (context) {
                                          return NumberSelectionAlertDialog(
                                            fieldKey: 'floorNumber',
                                            startIndex: 1,
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
                                          text: propertyAddAdCubit
                                                      .floorNumber ==
                                                  null
                                              ? ''
                                              : propertyAddAdCubit.floorNumber
                                                  .toString(),
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        propertyAddAdCubit.floorNumber == null
                                            ? SizedBox()
                                            : Spacer(),
                                        TextWidget(
                                          text:
                                              S.of(context).FloorNumberOptional,
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
                                    focusNode.unfocus();
                                    titleFocusNode.unfocus();
                                    descriptionFocusNode.unfocus();
                                    phoneFocusNode.unfocus();
                                    priceFocusNode.unfocus();
                                    totalAreaFocusNode.unfocus();
                                    netAreaFocusNode.unfocus();
                                    addressFocusNode.unfocus();
                                    complexNameFocusNode.unfocus();
                                    _scrollController
                                        .jumpTo(_scrollController.offset);
                                    showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (context) {
                                          return NumberSelectionAlertDialog(
                                            fieldKey: 'floorCount',
                                            startIndex: 1,
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
                                          text: propertyAddAdCubit.floorCount ==
                                                  null
                                              ? ''
                                              : propertyAddAdCubit.floorCount
                                                  .toString(),
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        propertyAddAdCubit.floorCount == null
                                            ? SizedBox()
                                            : Spacer(),
                                        TextWidget(
                                          text:
                                              S.of(context).FloorCountOptional,
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
                                9,
                                15
                              ].contains(propertyAddAdCubit.categoryForAdType),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: ButtonWidget(
                                  onTap: () {
                                    focusNode.unfocus();
                                    titleFocusNode.unfocus();
                                    descriptionFocusNode.unfocus();
                                    phoneFocusNode.unfocus();
                                    priceFocusNode.unfocus();
                                    totalAreaFocusNode.unfocus();
                                    netAreaFocusNode.unfocus();
                                    addressFocusNode.unfocus();
                                    complexNameFocusNode.unfocus();
                                    _scrollController
                                        .jumpTo(_scrollController.offset);
                                    showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (context) {
                                          return NumberSelectionAlertDialog(
                                            fieldKey: 'balconyCount',
                                            startIndex: 1,
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
                                          text: propertyAddAdCubit
                                                      .balconyCount ==
                                                  null
                                              ? ''
                                              : propertyAddAdCubit.balconyCount
                                                  .toString(),
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        propertyAddAdCubit.balconyCount == null
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
                              visible: ![
                                11,
                                17,
                                7
                              ].contains(propertyAddAdCubit.categoryForAdType),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: ButtonWidget(
                                  onTap: () async {
                                    focusNode.unfocus();
                                    titleFocusNode.unfocus();
                                    descriptionFocusNode.unfocus();
                                    phoneFocusNode.unfocus();
                                    priceFocusNode.unfocus();
                                    totalAreaFocusNode.unfocus();
                                    netAreaFocusNode.unfocus();
                                    addressFocusNode.unfocus();
                                    complexNameFocusNode.unfocus();
                                    _scrollController
                                        .jumpTo(_scrollController.offset);
                                    final date = await showDatePicker(
                                      helpText: S
                                          .of(context)
                                          .SelectDate, // Can be used as title
                                      cancelText: S.of(context).Close,
                                      confirmText: S.of(context).Select,
                                      context: context,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                      builder: (BuildContext context,
                                          Widget? child) {
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

                                    propertyAddAdCubit.changeConstructionDate(
                                        date: date);
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
                                          text: propertyAddAdCubit
                                                      .constructionDate !=
                                                  null
                                              ? '${Formatter.convertArabicNumbersToEnglish(DateFormat('dd/MM/yyy').format(propertyAddAdCubit.constructionDate!))}'
                                              : '',
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        propertyAddAdCubit.constructionDate ==
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
                              visible: ![
                                11,
                                17,
                                9,
                                15,
                                10,
                                16,
                                13,
                                19
                              ].contains(propertyAddAdCubit.categoryForAdType),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: ButtonWidget(
                                  onTap: () {
                                    focusNode.unfocus();
                                    titleFocusNode.unfocus();
                                    descriptionFocusNode.unfocus();
                                    phoneFocusNode.unfocus();
                                    priceFocusNode.unfocus();
                                    totalAreaFocusNode.unfocus();
                                    netAreaFocusNode.unfocus();
                                    addressFocusNode.unfocus();
                                    complexNameFocusNode.unfocus();
                                    _scrollController
                                        .jumpTo(_scrollController.offset);
                                    showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (context) {
                                          return FurnishedOrUnfurnishedAlertDialog();
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
                                        propertyAddAdCubit.furnishStatus == null
                                            ? TextWidget(
                                                text: S
                                                    .of(context)
                                                    .FurnishedOptional,
                                                fontSize: 16,
                                                color: Colors.black38,
                                              )
                                            : TextWidget(
                                                text: propertyAddAdCubit
                                                            .furnishStatus ==
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
                            Visibility(
                              visible: ![
                                11,
                                17,
                                9,
                                15,
                                13,
                                19
                              ].contains(propertyAddAdCubit.categoryForAdType),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: ButtonWidget(
                                  onTap: () {
                                    focusNode.unfocus();
                                    titleFocusNode.unfocus();
                                    descriptionFocusNode.unfocus();
                                    phoneFocusNode.unfocus();
                                    priceFocusNode.unfocus();
                                    totalAreaFocusNode.unfocus();
                                    netAreaFocusNode.unfocus();
                                    addressFocusNode.unfocus();
                                    complexNameFocusNode.unfocus();
                                    _scrollController
                                        .jumpTo(_scrollController.offset);
                                    propertyAddAdCubit.getFeatures();

                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AdFeaturesAlertDialog();
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
                                          text: S.of(context).FeaturesOptional,
                                          fontSize: 16,
                                          color: Colors.black38,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            propertyAddAdCubit.featuresListId!.isNotEmpty
                                ? 12.toHeight
                                : 0.toHeight,
                            Row(
                              children: [
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children:
                                      propertyAddAdCubit.featuresListId.map(
                                    (id) {
                                      final featureName = propertyAddAdCubit
                                          .features
                                          .firstWhere(
                                              (feature) =>
                                                  feature.featureId == id,
                                              orElse: () => FeatureModel(
                                                  featureId: id,
                                                  featureName: 'غير معروف',
                                                  featureIcon: ''))
                                          .featureName;

                                      return ButtonWidget(
                                        paddingHorizontal: 12,
                                        paddingVertical: 6,
                                        borderRadius: 4,
                                        height: 0,
                                        width: 0.2,
                                        onTap: () {},
                                        text: featureName,
                                        color: Colors.grey,
                                      );
                                    },
                                  ).toList(),
                                ),
                              ],
                            ),
                            12.toHeight,
                            BlocBuilder<AddAdGlobalCubit, AddAdGlobalState>(
                              builder: (context, state) {
                                return ButtonWidget(
                                  onTap: () {
                                    focusNode.unfocus();
                                    titleFocusNode.unfocus();
                                    descriptionFocusNode.unfocus();
                                    phoneFocusNode.unfocus();
                                    priceFocusNode.unfocus();
                                    totalAreaFocusNode.unfocus();
                                    netAreaFocusNode.unfocus();
                                    addressFocusNode.unfocus();
                                    complexNameFocusNode.unfocus();
                                    _scrollController
                                        .jumpTo(_scrollController.offset);
                                    showDialog(
                                        barrierDismissible: true,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Row(
                                      children: [
                                        addAdGlobalCubit.sellerType == null
                                            ? TextWidget(
                                                text:
                                                    S.of(context).PropertyOwner,
                                                fontSize: 16,
                                                color: Colors.black38,
                                              )
                                            : TextWidget(
                                                text: addAdGlobalCubit
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
                                );
                              },
                            ),
                            12.toHeight,
                            BlocBuilder<AddAdGlobalCubit, AddAdGlobalState>(
                              builder: (context, state) {
                                return ButtonWidget(
                                  onTap: () {
                                    focusNode.unfocus();
                                    titleFocusNode.unfocus();
                                    descriptionFocusNode.unfocus();
                                    phoneFocusNode.unfocus();
                                    priceFocusNode.unfocus();
                                    totalAreaFocusNode.unfocus();
                                    netAreaFocusNode.unfocus();
                                    addressFocusNode.unfocus();
                                    complexNameFocusNode.unfocus();
                                    _scrollController
                                        .jumpTo(_scrollController.offset);
                                    showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (context) {
                                          return CitySelectionAlertDialog();
                                        });

                                    if (addAdGlobalCubit.districtId != null) {
                                      addAdGlobalCubit.districtId = null;
                                    }
                                    // addAdGlobalCubit.changeCityId(
                                    //     id: settingsCubit.cityId!);
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
                                          text: addAdGlobalCubit.cityId != null
                                              ? settingsCubit
                                                  .globalCities[
                                                      addAdGlobalCubit.cityId! -
                                                          1]
                                                  .cityName
                                              : S.of(context).City,
                                          fontSize: 16,
                                          color: addAdGlobalCubit.cityId != null
                                              ? Colors.black
                                              : Colors.black38,
                                          fontWeight:
                                              addAdGlobalCubit.cityId != null
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
                            BlocBuilder<AddAdGlobalCubit, AddAdGlobalState>(
                              builder: (context, state) {
                                return ButtonWidget(
                                  onTap: () {
                                    focusNode.unfocus();
                                    titleFocusNode.unfocus();
                                    descriptionFocusNode.unfocus();
                                    phoneFocusNode.unfocus();
                                    priceFocusNode.unfocus();
                                    totalAreaFocusNode.unfocus();
                                    netAreaFocusNode.unfocus();
                                    addressFocusNode.unfocus();
                                    complexNameFocusNode.unfocus();
                                    _scrollController
                                        .jumpTo(_scrollController.offset);
                                    if (addAdGlobalCubit.cityId == null) {
                                      SnackbarUtils.showSnackbar(
                                          context, 'برجاء اختيار المدينة اولا');
                                    } else {
                                      showDialog(
                                          barrierDismissible: true,
                                          context: context,
                                          builder: (context) {
                                            return DistrictSelectionAlertDialog();
                                          });
                                    }
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
                                          text: addAdGlobalCubit.districtId !=
                                                  null
                                              ? settingsCubit
                                                  .globalDistricts[
                                                      addAdGlobalCubit
                                                              .districtId! -
                                                          1]
                                                  .districtName
                                              : S.of(context).Region,
                                          fontSize: 16,
                                          color: addAdGlobalCubit.districtId !=
                                                  null
                                              ? Colors.black
                                              : Colors.black38,
                                          fontWeight:
                                              addAdGlobalCubit.districtId !=
                                                      null
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
                            TextFieldWidget(
                              focusNode: addressFocusNode,
                              paddingVertical: 8,
                              maxLines: 2,
                              hint: S.of(context).NeighborhoodAndStreetOptional,
                              // onChanged: (value) {
                              //   propertyAddAdCubit.setPropertyField(
                              //       'adModelAddress', value);
                              // },
                              controller: addressController,
                            ),
                            Visibility(
                              visible: ![
                                11,
                                17,
                                13,
                                19
                              ].contains(propertyAddAdCubit.categoryForAdType),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: TextFieldWidget(
                                  focusNode: complexNameFocusNode,
                                  // onChanged: (value) {
                                  //   propertyAddAdCubit.setPropertyField(
                                  //       'complexName', value);
                                  // },
                                  controller: complexNameController,
                                  paddingVertical: 8,
                                  maxLines: 1,
                                  hint: S
                                      .of(context)
                                      .BuildingOrComplexNameOptional,
                                ),
                              ),
                            ),
                            8.toHeight,
                            BlocBuilder<AddAdGlobalCubit, AddAdGlobalState>(
                              builder: (context, state) {
                                return addAdGlobalCubit.location == null
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
                                                initialCenter: addAdGlobalCubit
                                                    .parseLatLng(
                                                        addAdGlobalCubit
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
                                                      point: addAdGlobalCubit
                                                          .parseLatLng(
                                                              addAdGlobalCubit
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
                                      );
                              },
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
                      if (titleAdController.text.isEmpty ||
                          phoneNumberController.text.isEmpty ||
                          priceController.text.isEmpty ||
                          totalAreaController.text.isEmpty ||
                          addAdGlobalCubit.sellerType == null ||
                          addAdGlobalCubit.districtId == null ||
                          addAdGlobalCubit.location == null ||
                          ([8, 14, 26, 27, 12, 18].contains(
                                  propertyAddAdCubit.categoryForAdType) &&
                              (propertyAddAdCubit.roomCount == null ||
                                  propertyAddAdCubit.bathroomCount == null))) {
                        SnackbarUtils.showSnackbar(
                          context,
                          S.of(context).AddAdWarning,
                          2,
                        );
                      } else {
                        pageTransition(
                          context,
                          page: FinishPage(
                            isEdit: widget.itIsEdit,
                            adTitle: titleAdController.text,
                            totalArea: totalAreaController.text,
                            phoneNumber: phoneNumberController.text,
                            price: priceController.text,
                            netArea: netAreaController.text,
                            description: descriptionController.text,
                            address: addressController.text,
                            complexName: complexNameController.text,
                          ),
                        );
                      }
                      // pageTransition(context,
                      //     page: FinishPage(
                      //       adTitle: titleAdController.text,
                      //       totalArea: totalAreaController.text,
                      //       phoneNumber: phoneNumberController.text,
                      //       price: priceController.text,
                      //       netArea: netAreaController.text,
                      //       description: descriptionController.text,
                      //       address: addressController.text,
                      //       complexName: complexNameController.text,
                      //     ));
                      //  Navigator.pushNamed(context, FinishPage.id);
                    },
                    text: S.of(context).Apply,
                    height: 0.06,
                    width: 1,
                    color: AppColors.primary,
                    fontSize: 18,
                    colorText: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

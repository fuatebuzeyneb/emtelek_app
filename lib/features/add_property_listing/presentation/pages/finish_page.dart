import 'dart:io';

import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/core/utils/snackbar_utils.dart';
import 'package:emtelek/features/add_property_listing/data/models/add_property_ad_request_model.dart';
import 'package:emtelek/features/add_property_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/features/home/data/models/property_model.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/cubits/cubit/add_ad_global_cubit.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/widgets/appbar_widget.dart';
import 'package:emtelek/shared/widgets/bottom_nav_bar.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/loading_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class FinishPage extends StatelessWidget {
  final String adTitle;
  final String phoneNumber;
  final String price;
  final String totalArea;
  final String? netArea;
  final String? description;
  final String? address;
  final String? complexName;
  final bool isEdit;
  const FinishPage(
      {super.key,
      required this.adTitle,
      required this.phoneNumber,
      required this.price,
      required this.totalArea,
      this.netArea,
      this.description,
      this.address,
      this.complexName,
      required this.isEdit});
  static const String id = 'FinishPage';

  // final titleAdController = TextEditingController();
  // final phoneNumberController = TextEditingController();
  // final priceController = TextEditingController();
  // final totalAreaController = TextEditingController();
  // final netAreaController = TextEditingController();
  // final descriptionController = TextEditingController();
  // final addressController = TextEditingController();
  // final complexNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    PropertyAddAdCubit propertyAddAdCubit =
        BlocProvider.of<PropertyAddAdCubit>(context);
    AddAdGlobalCubit addAdGlobalCubit = context.read<AddAdGlobalCubit>();

    return BlocConsumer<PropertyAddAdCubit, PropertyAddAdState>(
      listener: (context, state) {
        if (state is PropertyAddAdSuccess) {
          SnackbarUtils.showSnackbar(context, 'تم اضافة الاعلان بنجاح');
          pageTransition(
            context,
            page: const BottomNavBar(),
          );
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
        } else if (state is PropertyUpdateAdSuccess) {
          SnackbarUtils.showSnackbar(context, 'تم تعديل الاعلان بنجاح');
        } else if (state is PropertyAddOrUpdateAdFailure) {
          SnackbarUtils.showSnackbar(context, state.errorMassage, 5);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is PropertyAddOrUpdateAdLoading,
          progressIndicator: const LoadingWidget(),
          child: Scaffold(
            appBar: AppBarWidget(
              title: '',
              widget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: S.of(context).AdPreview,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: TextWidget(
                          text: 'Edit',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ]),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color(0xFFEDF2F8),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: ButtonWidget(
                showElevation: true,
                boxShadowOpacity: 0.2,
                color: Colors.white,
                height: 0,
                width: 1,
                onTap: () {},
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              12.toHeight,
                              TextWidget(
                                  text: 'تفاصيل الاعلان',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                              Divider(),
                              Row(
                                children: [
                                  TextWidget(
                                      text: 'نوع الاعلان:',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: settingsCubit.rentCategories
                                            .containsKey(propertyAddAdCubit
                                                .categoryForAdType)
                                        ? ' ' +
                                            '${settingsCubit.rentCategories[propertyAddAdCubit.categoryForAdType]} ${S.of(context).ForRent}'
                                        : ' ' +
                                            '${settingsCubit.saleCategories[propertyAddAdCubit.categoryForAdType]} ${S.of(context).ForSale}',
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).AdTitle}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  Expanded(
                                    child: TextWidget(
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      isHaveOverflow: true,
                                      text: adTitle,
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).Area}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: totalArea,
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).NetArea}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: netArea ?? S.of(context).undefined,
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).NumberOfRooms}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text:
                                        propertyAddAdCubit.roomCount.toString(),
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text:
                                          '${S.of(context).NumberOfBathrooms}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit.bathroomCount
                                        .toString(),
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).FloorNumber}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit.floorNumber == null
                                        ? S.of(context).undefined
                                        : propertyAddAdCubit.floorNumber
                                            .toString(),
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).FloorCount}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit.floorCount == null
                                        ? S.of(context).undefined
                                        : propertyAddAdCubit.floorCount
                                            .toString(),
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text:
                                          '${S.of(context).NumberOfBalconies}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text:
                                        propertyAddAdCubit.balconyCount == null
                                            ? S.of(context).undefined
                                            : propertyAddAdCubit.balconyCount
                                                .toString(),
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text:
                                          '${S.of(context).ConstructionDate}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit.constructionDate ==
                                            null
                                        ? S.of(context).undefined
                                        : propertyAddAdCubit.constructionDate
                                            .toString(),
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).Furnished}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit.furnishStatus ==
                                            null
                                        ? S.of(context).undefined
                                        : propertyAddAdCubit.furnishStatus ==
                                                true
                                            ? S.of(context).Furnished
                                            : S.of(context).Unfurnished,
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).PropertyOwner}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: addAdGlobalCubit.sellerType! == 1
                                        ? S.of(context).Owner
                                        : S.of(context).Agent,
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              description == null || description == ''
                                  ? Row(
                                      children: [
                                        TextWidget(
                                            text:
                                                '${S.of(context).Description}: ',
                                            fontSize: 16,
                                            color: Colors.black),
                                        TextWidget(
                                          text: S.of(context).undefined,
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                            text:
                                                '${S.of(context).Description}: ',
                                            fontSize: 16,
                                            color: Colors.black),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: TextWidget(
                                            textAlign: TextAlign.start,
                                            text: description!,
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).Favorites}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit
                                            .featuresListId.isEmpty
                                        ? S.of(context).undefined
                                        : '',
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              propertyAddAdCubit.featuresListId.isEmpty
                                  ? 0.toHeight
                                  : 4.toHeight,
                              Row(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: propertyAddAdCubit
                                            .featuresListId
                                            .map(
                                          (id) {
                                            final featureName =
                                                propertyAddAdCubit.features
                                                    .firstWhere(
                                                      (feature) =>
                                                          feature.featureId ==
                                                          id,
                                                      orElse: () =>
                                                          FeatureModel(
                                                              featureId: id,
                                                              featureName:
                                                                  'غير معروف',
                                                              featureIcon: ''),
                                                    )
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
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
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
                              ),
                              20.toHeight,
                              TextWidget(
                                  text: 'تفاصيل السعر والموقع',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                              Divider(),
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).Price}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: price,
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).Currency}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: addAdGlobalCubit.currencyId,
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).City}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: settingsCubit.getCityNameByCityId(
                                        addAdGlobalCubit.cityId!),
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).Region}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: settingsCubit
                                        .getDistrictNameByDistrictId(
                                            addAdGlobalCubit.districtId!),
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text:
                                          '${S.of(context).NeighborhoodAndStreet}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: address == null || address == ''
                                        ? S.of(context).undefined
                                        : address!,
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text:
                                          '${S.of(context).BuildingOrComplexName}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text:
                                        complexName == null || complexName == ''
                                            ? S.of(context).undefined
                                            : complexName!,
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: ButtonWidget(
                                    height: 0.2,
                                    width: 1,
                                    onTap: () {},
                                    child: FlutterMap(
                                      key: const Key('map'),
                                      options: MapOptions(
                                        initialCenter:
                                            addAdGlobalCubit.parseLatLng(
                                                addAdGlobalCubit.location!),
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
                                                  .parseLatLng(addAdGlobalCubit
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
                                ),
                              ),
                              20.toHeight,
                              TextWidget(
                                  text: 'معلومات التواصل',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                              Divider(),
                              Row(
                                children: [
                                  TextWidget(
                                      text:
                                          '${S.of(context).FirstName} ${S.of(context).LastName}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text:
                                        '${getIt<CacheHelper>().getDataString(key: 'firstName')!} ${getIt<CacheHelper>().getDataString(key: 'lastName')!}',
                                    //  propertyAddAdCubit
                                    //         .adModel.client!.phoneNumber ??
                                    //     S.of(context).undefined,
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).PhoneNumber}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: phoneNumber,
                                    //  propertyAddAdCubit
                                    //         .adModel.client!.phoneNumber ??
                                    //     S.of(context).undefined,
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).Email}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: getIt<CacheHelper>()
                                        .getDataString(key: 'email')!,
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonWidget(
                        onTap: () {
                          final model = AddPropertyAdRequestModel(
                            phoneNumber: int.parse(phoneNumber),
                            token: getIt<CacheHelper>().getData(key: 'token'),
                            clientId:
                                getIt<CacheHelper>().getData(key: 'clientId'),
                            adTitle: adTitle,
                            categoryId: propertyAddAdCubit.categoryForAdType!,
                            districtId: addAdGlobalCubit.districtId!,
                            price: double.parse(price),
                            currency: addAdGlobalCubit.currencyId,
                            sellerType: addAdGlobalCubit.sellerType!,
                            location: addAdGlobalCubit.location!,
                            totalArea: int.parse(totalArea),
                            roomCount: propertyAddAdCubit.roomCount!,
                            bathroomCount: propertyAddAdCubit.bathroomCount!,
                            description: description,
                            netArea: netArea == '' || netArea == null
                                ? null
                                : int.parse(netArea!),
                            address: address,
                            floorCount: propertyAddAdCubit.floorCount,
                            floorNumber: propertyAddAdCubit.floorNumber,
                            furnish: propertyAddAdCubit.furnishStatus == true
                                ? 'yes'
                                : 'no',
                            constructionDate:
                                propertyAddAdCubit.constructionDate == null
                                    ? 'null'
                                    : DateFormat('yyyy-MM-dd').format(
                                        propertyAddAdCubit.constructionDate!),
                            complexName: complexName,
                            balconyCount: propertyAddAdCubit.balconyCount,
                          );

                          print("🚀 addAdPropertyFunc STARTED");

                          if (isEdit == true) {
                            propertyAddAdCubit.editAdPropertyFunc(
                                addPropertyAdRequestModel: model);
                          } else {
                            propertyAddAdCubit.addAdPropertyFunc(
                                addPropertyAdRequestModel: model);
                          }
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
              ),
            ),
          ),
        );
      },
    );
  }
}

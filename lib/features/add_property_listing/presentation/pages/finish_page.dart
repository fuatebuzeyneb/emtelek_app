import 'dart:io';

import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/core/utils/snackbar_utils.dart';
import 'package:emtelek/features/add_property_listing/domain/cubit/property_add_ad_cubit.dart';
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
  const FinishPage(
      {super.key,
      required this.adTitle,
      required this.phoneNumber,
      required this.price,
      required this.totalArea,
      this.netArea,
      this.description,
      this.address,
      this.complexName});
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
        //   if (state is PropertyAddAdSuccess) {
        SnackbarUtils.showSnackbar(context, 'تم اضافة الاعلان بنجاح');
        pageTransition(context, page: const BottomNavBar());
        // } else if (state is PropertyAddAdFailure) {
        //   SnackbarUtils.showSnackbar(context, state.errorMassage);
        // }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is PropertyAddOrUpdateAdLoading,
          progressIndicator: const LoadingWidget(),
          child: Scaffold(
            appBar: AppBarWidget(
              title: S.of(context).AdPreview,
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
                                      // propertyAddAdCubit.adModel.adTitle ??
                                      //     S.of(context).undefined,
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
                                    //  propertyAddAdCubit
                                    //             .adModel.info!.totalArea ==
                                    //         null
                                    //     ? S.of(context).undefined
                                    //     : propertyAddAdCubit
                                    //         .adModel.info!.totalArea
                                    //         .toString(),
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
                                    text: 'sadasd',
                                    //  propertyAddAdCubit
                                    //             .adModel.info!.netArea ==
                                    //         null
                                    //     ? S.of(context).undefined
                                    //     : propertyAddAdCubit
                                    //         .adModel.info!.netArea
                                    //         .toString(),
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
                                      text: '${S.of(context).Description}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: 'fsdfsd',
                                    // propertyAddAdCubit
                                    //         .adModel.description ??
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
                                      text: '${S.of(context).NumberOfRooms}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: 'sadas',
                                    //  propertyAddAdCubit
                                    //             .adModel.info!.roomCount ==
                                    //         null
                                    //     ? S.of(context).undefined
                                    //     : propertyAddAdCubit
                                    //         .adModel.info!.roomCount
                                    //         .toString(),
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
                                    text: 'saasd',
                                    //  propertyAddAdCubit
                                    //             .adModel.info!.bathroomCount ==
                                    //         null
                                    //     ? S.of(context).undefined
                                    //     : propertyAddAdCubit
                                    //         .adModel.info!.bathroomCount
                                    //         .toString(),
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
                                    text: 'sadsad',
                                    //  propertyAddAdCubit
                                    //             .adModel.info!.bathroomCount ==
                                    //         null
                                    //     ? S.of(context).undefined
                                    //     : propertyAddAdCubit
                                    //         .adModel.info!.bathroomCount
                                    //         .toString(),
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
                                    text: 'asdasd',

                                    //  propertyAddAdCubit
                                    //             .adModel.info!.floorNumber ==
                                    //         null
                                    //     ? S.of(context).undefined
                                    //     : propertyAddAdCubit
                                    //         .adModel.info!.floorNumber
                                    //         .toString(),
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
                                    text: 'das',
                                    // propertyAddAdCubit
                                    //             .adModel.info!.floorCount ==
                                    //         null
                                    //     ? S.of(context).undefined
                                    //     : propertyAddAdCubit
                                    //         .adModel.info!.floorCount
                                    //         .toString(),
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
                                    text: 'asdasd',
                                    // propertyAddAdCubit
                                    //             .adModel.info!.balconyCount ==
                                    //         null
                                    //     ? S.of(context).undefined
                                    //     : propertyAddAdCubit
                                    //         .adModel.info!.balconyCount
                                    //         .toString(),
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
                                          '${S.of(context).ConstructionDateOptional}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: 'sdfsdfs',
                                    // propertyAddAdCubit.adModel.info!
                                    //             .constructionDate ==
                                    //         null
                                    //     ? S.of(context).undefined
                                    //     : propertyAddAdCubit
                                    //         .adModel.info!.constructionDate
                                    //         .toString(),
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
                                    text: 'dfsdfs',

                                    //  propertyAddAdCubit
                                    //             .adModel.info!.furnish ==
                                    //         null
                                    //     ? S.of(context).undefined
                                    //     : propertyAddAdCubit
                                    //                 .adModel.info!.furnish ==
                                    //             'yes'
                                    //         ? S.of(context).Furnished
                                    //         : S.of(context).Unfurnished,
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
                                    text: 'sasas',
                                    // propertyAddAdCubit.adModel.sellerType ==
                                    //         null
                                    //     ? S.of(context).undefined
                                    //     : propertyAddAdCubit
                                    //                 .adModel.sellerType ==
                                    //             1
                                    //         ? S.of(context).Owner
                                    //         : S.of(context).Agent,
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
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
                                                        BorderRadius.circular(
                                                            8),
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
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          )),
                                    )
                                  : SizedBox(),
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
                                    text: 'popopopop',
                                    // propertyAddAdCubit.adModel.price == null
                                    //     ? S.of(context).undefined
                                    //     : propertyAddAdCubit.adModel.price
                                    //         .toString(),
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
                                    text: 'iuiiuiu',
                                    // propertyAddAdCubit.adModel.currency ??
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
                                      text: '${S.of(context).City}: ',
                                      fontSize: 16,
                                      color: Colors.black),
                                  TextWidget(
                                    text: 'qqq',

                                    // settingsCubit.cityId != null
                                    //     ? settingsCubit
                                    //         .globalCities[
                                    //             settingsCubit.cityId! - 1]
                                    //         .cityName
                                    //     : S.of(context).undefined,
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
                                    text: 'dfsfd',

                                    //  propertyAddAdCubit
                                    //             .adModel.district!.districtId !=
                                    //         null
                                    //     ? settingsCubit
                                    //         .globalDistricts[propertyAddAdCubit
                                    //                 .adModel
                                    //                 .district!
                                    //                 .districtId! -
                                    //             1]
                                    //         .districtName
                                    //     : S.of(context).undefined,
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
                                    text: 'reee',
                                    //  propertyAddAdCubit
                                    //             .adModel.info!.address ==
                                    //         null
                                    //     ? S.of(context).undefined
                                    //     : propertyAddAdCubit
                                    //         .adModel.info!.address
                                    //         .toString(),
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
                                    text: 'ttt',

                                    // propertyAddAdCubit
                                    //             .adModel.info!.complexName ==
                                    //         null
                                    //     ? S.of(context).undefined
                                    //     : propertyAddAdCubit
                                    //         .adModel.info!.complexName
                                    //         .toString(),
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              addAdGlobalCubit.location == null
                                  ? ButtonWidget(
                                      height: 0.15,
                                      width: 1,
                                      colorText: Colors.black45,
                                      ////  color: Colors.redAccent,
                                      borderColor: Colors.grey,
                                      text: 'لم يتم تحدد الموقع',
                                      onTap: () {},
                                    )
                                  : Padding(
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
                                              initialCenter: addAdGlobalCubit
                                                  .parseLatLng(addAdGlobalCubit
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
                                    text: 'ieqeowe',
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
                                    //  propertyAddAdCubit
                                    //         .adModel.client!.phoneNumber ??
                                    //     S.of(context).undefined,
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
                          // propertyAddAdCubit.setPropertyField(
                          //     'adModelCategoryId',
                          //     propertyAddAdCubit.categoryForAdType);
                          // print("🚀 addAdPropertyFunc STARTED");
                          // propertyAddAdCubit.addAdPropertyFunc();
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

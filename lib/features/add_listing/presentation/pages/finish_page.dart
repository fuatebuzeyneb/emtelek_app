import 'dart:io';

import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/core/utils/snackbar_utils.dart';
import 'package:emtelek/features/add_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/widgets/appbar_widget.dart';
import 'package:emtelek/shared/widgets/bottom_nav_bar.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/list_title_section_widget.dart';
import 'package:emtelek/shared/widgets/loading_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class FinishPage extends StatelessWidget {
  const FinishPage({super.key});
  static const String id = 'FinishPage';

  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    PropertyAddAdCubit propertyAddAdCubit =
        BlocProvider.of<PropertyAddAdCubit>(context);

    return BlocConsumer<PropertyAddAdCubit, PropertyAddAdState>(
      listener: (context, state) {
        if (state is PropertyAddAdSuccess) {
          SnackbarUtils.showSnackbar(context, 'تم اضافة الاعلان بنجاح');
          pageTransition(context, page: const BottomNavBar());
        } else if (state is PropertyAddAdFailure) {
          SnackbarUtils.showSnackbar(context, state.errorMassage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is PropertyAddAdLoading,
          progressIndicator: const LoadingWidget(),
          child: Scaffold(
            appBar: AppBarWidget(
              title: 'مراجعة الاعلان',
              isHaveBackButton: false,
              widget: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: TextWidget(
                  text: 'تعديل',
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            backgroundColor: Colors.grey.shade200,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: ButtonWidget(
                showElevation: true,
                color: Colors.white,
                height: 0,
                width: 1,
                onTap: () {},
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTitleSection(
                                title: 'نوع الاعلان',
                                value: settingsCubit.rentCategories.containsKey(
                                        propertyAddAdCubit.categoryForAdType)
                                    ? '${settingsCubit.rentCategories[propertyAddAdCubit.categoryForAdType]} ${S.of(context).ForRent}'
                                    : '${settingsCubit.saleCategories[propertyAddAdCubit.categoryForAdType]} ${S.of(context).ForSale}',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 4,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: 'صور الاعلان',
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
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
                                    SizedBox(
                                      child: Divider(),
                                    )
                                  ],
                                ),
                              ),
                              ListTitleSection(
                                title: S.of(context).AdTitle,
                                value: settingsCubit.rentCategories.containsKey(
                                        propertyAddAdCubit.categoryForAdType)
                                    ? '${settingsCubit.rentCategories[propertyAddAdCubit.categoryForAdType]} ${S.of(context).ForRent}'
                                    : '${settingsCubit.saleCategories[propertyAddAdCubit.categoryForAdType]} ${S.of(context).ForSale}',
                              ),
                              ListTitleSection(
                                title: S.of(context).PhoneNumber,
                                value: propertyAddAdCubit
                                        .adModel.client.phoneNumber ??
                                    S.of(context).undefined,
                              ),
                              ListTitleSection(
                                title: S.of(context).Price,
                                value:
                                    propertyAddAdCubit.adModel.price.toString(),
                              ),
                              ListTitleSection(
                                title: S.of(context).Currency,
                                value: propertyAddAdCubit.adModel.currency!,
                              ),
                              ListTitleSection(
                                title: S.of(context).Area,
                                value:
                                    propertyAddAdCubit.adModel.info.totalArea!,
                              ),
                              ListTitleSection(
                                title: S.of(context).NetArea,
                                value: propertyAddAdCubit
                                            .adModel.info.netArea ==
                                        null
                                    ? S.of(context).undefined
                                    : propertyAddAdCubit.adModel.info.netArea
                                        .toString(),
                              ),
                              ListTitleSection(
                                title: S.of(context).Description,
                                value: propertyAddAdCubit.adModel.description ??
                                    S.of(context).undefined,
                              ),
                              ListTitleSection(
                                title: S.of(context).NumberOfRooms,
                                value: propertyAddAdCubit
                                            .adModel.info.roomCount ==
                                        null
                                    ? S.of(context).undefined
                                    : propertyAddAdCubit.adModel.info.roomCount
                                        .toString(),
                              ),
                              ListTitleSection(
                                title: S.of(context).NumberOfBathrooms,
                                value: propertyAddAdCubit
                                            .adModel.info.bathroomCount ==
                                        null
                                    ? S.of(context).undefined
                                    : propertyAddAdCubit
                                        .adModel.info.bathroomCount
                                        .toString(),
                              ),
                              ListTitleSection(
                                title: S.of(context).FloorNumber,
                                value: propertyAddAdCubit
                                            .adModel.info.floorNumber ==
                                        null
                                    ? S.of(context).undefined
                                    : propertyAddAdCubit
                                        .adModel.info.floorNumber
                                        .toString(),
                              ),
                              ListTitleSection(
                                title: S.of(context).FloorCount,
                                value: propertyAddAdCubit
                                            .adModel.info.floorCount ==
                                        null
                                    ? S.of(context).undefined
                                    : propertyAddAdCubit.adModel.info.floorCount
                                        .toString(),
                              ),
                              ListTitleSection(
                                title: S.of(context).NumberOfBalconies,
                                value: propertyAddAdCubit
                                            .adModel.info.balconyCount ==
                                        null
                                    ? S.of(context).undefined
                                    : propertyAddAdCubit
                                        .adModel.info.balconyCount
                                        .toString(),
                              ),
                              ListTitleSection(
                                title: S.of(context).ConstructionDateOptional,
                                value: propertyAddAdCubit
                                            .adModel.info.constructionDate ==
                                        null
                                    ? S.of(context).undefined
                                    : propertyAddAdCubit
                                        .adModel.info.constructionDate
                                        .toString(),
                              ),
                              ListTitleSection(
                                title: S.of(context).Furnished,
                                value: propertyAddAdCubit
                                            .adModel.info.furnish ==
                                        null
                                    ? S.of(context).undefined
                                    : propertyAddAdCubit.adModel.info.furnish ==
                                            true
                                        ? S.of(context).Furnished
                                        : S.of(context).Unfurnished,
                              ),
                              ListTitleSection(
                                title: S.of(context).PropertyOwner,
                                value: propertyAddAdCubit.adModel.sellerType ==
                                        null
                                    ? S.of(context).undefined
                                    : propertyAddAdCubit.adModel.sellerType == 1
                                        ? S.of(context).Owner
                                        : S.of(context).Agent,
                              ),
                              ListTitleSection(
                                  title: S.of(context).City,
                                  value: settingsCubit
                                      .globalCities[settingsCubit.cityId! - 1]
                                      .cityName),
                              ListTitleSection(
                                  title: S.of(context).Region,
                                  value: settingsCubit
                                      .globalDistricts[propertyAddAdCubit
                                              .adModel.district.districtId! -
                                          1]
                                      .districtName),
                              ListTitleSection(
                                title: S.of(context).NeighborhoodAndStreet,
                                value: propertyAddAdCubit
                                            .adModel.info.address ==
                                        null
                                    ? S.of(context).undefined
                                    : propertyAddAdCubit.adModel.info.address
                                        .toString(),
                              ),
                              ListTitleSection(
                                title: S.of(context).BuildingOrComplexName,
                                value: propertyAddAdCubit
                                            .adModel.info.complexName ==
                                        null
                                    ? S.of(context).undefined
                                    : propertyAddAdCubit
                                        .adModel.info.complexName
                                        .toString(),
                              ),
                              ButtonWidget(
                                height: 0.2,
                                width: 1,
                                onTap: () {},
                                child: FlutterMap(
                                  key: const Key('map'),
                                  options: MapOptions(
                                    initialCenter: settingsCubit.parseLatLng(
                                        propertyAddAdCubit.adModel.location!),
                                  ),
                                  mapController: MapController(),
                                  children: [
                                    TileLayer(
                                      urlTemplate:
                                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      userAgentPackageName: 'com.example.app',
                                    ),
                                    MarkerLayer(
                                      markers: [
                                        Marker(
                                          point: settingsCubit.parseLatLng(
                                              propertyAddAdCubit
                                                  .adModel.location!),
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonWidget(
                        onTap: () {
                          propertyAddAdCubit.setPropertyField(
                              'adModelCategoryId',
                              propertyAddAdCubit.categoryForAdType);
                          print("🚀 addAdPropertyFunc STARTED");
                          propertyAddAdCubit.addAdPropertyFunc();
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







/*

import 'dart:io';

import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/core/utils/snackbar_utils.dart';
import 'package:emtelek/features/add_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
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
  const FinishPage({super.key});
  static const String id = 'FinishPage';

  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    PropertyAddAdCubit propertyAddAdCubit =
        BlocProvider.of<PropertyAddAdCubit>(context);

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
          inAsyncCall: state is PropertyAddAdLoading,
          progressIndicator: const LoadingWidget(),
          child: Scaffold(
            appBar: AppBar(
              shadowColor: Colors.white,
              elevation: 2,
              surfaceTintColor: Colors.white,
              automaticallyImplyLeading: false,
              title: AppBarWidget(
                title: S.of(context).AdPreview,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: AppColors.appBarBackground,
            ),
            backgroundColor: Colors.red,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: ButtonWidget(
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
                              ListTitleSection(
                                title: 'نوع الاعلان:',
                                value: settingsCubit.rentCategories.containsKey(
                                        propertyAddAdCubit.categoryForAdType)
                                    ? '${settingsCubit.rentCategories[propertyAddAdCubit.categoryForAdType]} ${S.of(context).ForRent}'
                                    : '${settingsCubit.saleCategories[propertyAddAdCubit.categoryForAdType]} ${S.of(context).ForSale}',
                              ),
                              Row(
                                children: [
                                  TextWidget(
                                      text: 'نوع الاعلان:',
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: settingsCubit.rentCategories
                                            .containsKey(propertyAddAdCubit
                                                .categoryForAdType)
                                        ? ' ${S.of(context).PropertyForRent} --> ${settingsCubit.rentCategories[propertyAddAdCubit.categoryForAdType]} ${S.of(context).ForRent}'
                                        : ' ${S.of(context).PropertyForSale} --> ${settingsCubit.saleCategories[propertyAddAdCubit.categoryForAdType]} ${S.of(context).ForSale}',
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
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
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).AdTitle}: ',
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit.adModel.adTitle ??
                                        S.of(context).undefined,
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
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit
                                            .adModel.client!.phoneNumber ??
                                        S.of(context).undefined,
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
                                      text: '${S.of(context).Price}: ',
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text:
                                        propertyAddAdCubit.adModel.price == null
                                            ? S.of(context).undefined
                                            : propertyAddAdCubit.adModel.price
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
                                      text: '${S.of(context).Currency}: ',
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit.adModel.currency ??
                                        S.of(context).undefined,
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
                                      text: '${S.of(context).Area}: ',
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit
                                                .adModel.info!.totalArea ==
                                            null
                                        ? S.of(context).undefined
                                        : propertyAddAdCubit
                                            .adModel.info!.totalArea
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
                                      text: '${S.of(context).NetArea}: ',
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit
                                                .adModel.info!.netArea ==
                                            null
                                        ? S.of(context).undefined
                                        : propertyAddAdCubit
                                            .adModel.info!.netArea
                                            .toString(),
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              4.toHeight,
                              ListTitleSection(
                                title: S.of(context).Description,
                                value: 'dfg',
                              ),
                              // Row(
                              //   children: [
                              //     TextWidget(
                              //         text: '${S.of(context).Description}: ',
                              //         fontSize: 18,
                              //         color: Colors.black),
                              //     TextWidget(
                              //       text: propertyAddAdCubit
                              //               .adModel.description ??
                              //           S.of(context).undefined,
                              //       fontSize: 14,
                              //       color: Colors.black,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ],
                              // ),
                              4.toHeight,
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).NumberOfRooms}: ',
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit
                                                .adModel.info!.roomCount ==
                                            null
                                        ? S.of(context).undefined
                                        : propertyAddAdCubit
                                            .adModel.info!.roomCount
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
                                          '${S.of(context).NumberOfBathrooms}: ',
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit
                                                .adModel.info!.bathroomCount ==
                                            null
                                        ? S.of(context).undefined
                                        : propertyAddAdCubit
                                            .adModel.info!.bathroomCount
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
                                          '${S.of(context).NumberOfBathrooms}: ',
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit
                                                .adModel.info!.bathroomCount ==
                                            null
                                        ? S.of(context).undefined
                                        : propertyAddAdCubit
                                            .adModel.info!.bathroomCount
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
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit
                                                .adModel.info!.floorNumber ==
                                            null
                                        ? S.of(context).undefined
                                        : propertyAddAdCubit
                                            .adModel.info!.floorNumber
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
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit
                                                .adModel.info!.floorCount ==
                                            null
                                        ? S.of(context).undefined
                                        : propertyAddAdCubit
                                            .adModel.info!.floorCount
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
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit
                                                .adModel.info!.balconyCount ==
                                            null
                                        ? S.of(context).undefined
                                        : propertyAddAdCubit
                                            .adModel.info!.balconyCount
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
                                          '${S.of(context).ConstructionDateOptional}: ',
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit.adModel.info!
                                                .constructionDate ==
                                            null
                                        ? S.of(context).undefined
                                        : propertyAddAdCubit
                                            .adModel.info!.constructionDate
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
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit
                                                .adModel.info!.furnish ==
                                            null
                                        ? S.of(context).undefined
                                        : propertyAddAdCubit
                                                    .adModel.info!.furnish ==
                                                'yes'
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
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text:
                                        propertyAddAdCubit.adModel.sellerType ==
                                                null
                                            ? S.of(context).undefined
                                            : propertyAddAdCubit
                                                        .adModel.sellerType ==
                                                    1
                                                ? S.of(context).Owner
                                                : S.of(context).Agent,
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
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: settingsCubit.cityId != null
                                        ? settingsCubit
                                            .globalCities[
                                                settingsCubit.cityId! - 1]
                                            .cityName
                                        : S.of(context).undefined,
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  TextWidget(
                                      text: '${S.of(context).Region}: ',
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit
                                                .adModel.district!.districtId !=
                                            null
                                        ? settingsCubit
                                            .globalDistricts[propertyAddAdCubit
                                                    .adModel
                                                    .district!
                                                    .districtId! -
                                                1]
                                            .districtName
                                        : S.of(context).undefined,
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
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit
                                                .adModel.info!.address ==
                                            null
                                        ? S.of(context).undefined
                                        : propertyAddAdCubit
                                            .adModel.info!.address
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
                                          '${S.of(context).BuildingOrComplexName}: ',
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget(
                                    text: propertyAddAdCubit
                                                .adModel.info!.complexName ==
                                            null
                                        ? S.of(context).undefined
                                        : propertyAddAdCubit
                                            .adModel.info!.complexName
                                            .toString(),
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              propertyAddAdCubit.adModel.location == null
                                  ? ButtonWidget(
                                      height: 0.15,
                                      width: 1,
                                      colorText: Colors.black45,
                                      ////  color: Colors.redAccent,
                                      borderColor: Colors.grey,
                                      text: 'لم يتم تحدد الموقع',
                                      onTap: () {},
                                    )
                                  : ButtonWidget(
                                      height: 0.2,
                                      width: 1,
                                      onTap: () {},
                                      child: FlutterMap(
                                        key: const Key('map'),
                                        options: MapOptions(
                                          initialCenter: settingsCubit
                                              .parseLatLng(propertyAddAdCubit
                                                  .adModel.location!),
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
                                                            .adModel.location!),
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonWidget(
                        onTap: () {
                          propertyAddAdCubit.setPropertyField(
                              'adModelCategoryId',
                              propertyAddAdCubit.categoryForAdType);
                          print("🚀 addAdPropertyFunc STARTED");
                          propertyAddAdCubit.addAdPropertyFunc();
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

class ListTitleSection extends StatelessWidget {
  final String title;
  final String value;

  const ListTitleSection({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(value),
          trailing: TextButton(
            onPressed: () {},
            child: Text(
              S.of(context).Description,
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}


*/
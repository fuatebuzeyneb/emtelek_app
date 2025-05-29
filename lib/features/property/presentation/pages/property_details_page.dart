import 'dart:ui';

import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/core/extensions/alignment_extension.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/favorites/presentation/widgets/favorite_widget.dart';
import 'package:emtelek/features/home/data/models/property_model.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/shared/cubits/ad_details_cubit/ad_details_cubit.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/helper/features_icon.dart';
import 'package:emtelek/shared/helper/founctions/formatter.dart';
import 'package:emtelek/shared/models/add-ads-models/add_ad_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/shared/common_pages/image_viewer_page.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyDetailsPage extends StatelessWidget {
  final Property adDetails;

  PropertyDetailsPage({
    super.key,
    required this.adDetails,
  });

  final Key mapKey = UniqueKey();

  final ScrollController scrollController = ScrollController();

  // final List<String> imageUrls = [
  //   'assets/images/example.png',
  //   'assets/images/example1.webp',
  //   'assets/images/example2.webp',
  //   'assets/images/example3.webp',
  //   'assets/images/example.png',
  //   'assets/images/example1.webp',
  //   'assets/images/example2.webp',
  //   'assets/images/example3.webp',
  // ];

  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    AdDetailsCubit adDetailsCubit = BlocProvider.of<AdDetailsCubit>(context);
    adDetailsCubit.showAppBarFunction(scrollController);
    final int totalFeatures =
        adDetails.features == false ? 0 : adDetails.features!.length;

    // final List<String> features = List.generate(adDetails.features.length,
    //     (index) => '${adDetails.features?[index].featureName}');
    // Alignment alignment =
    //     getIt<CacheHelper>().getDataString(key: 'Lang') == 'ar'
    //         ? Alignment.centerRight
    //         : Alignment.centerLeft;
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      BlocBuilder<AdDetailsCubit, AdDetailsState>(
                        builder: (context, state) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // pageTransition(context,
                                  //     page: ImageGalleryPage(
                                  //       adModel: adModel,
                                  //     ));
                                },
                                child: SizedBox(
                                  height: context.height * 0.34,
                                  child: ImageSlideshow(
                                    indicatorColor: AppColors.primary,
                                    onPageChanged: (value) {
                                      adDetailsCubit.currentPageFunction(value);
                                    },
                                    children: adDetails.images.values
                                        .map(
                                          (img) => Image.network(
                                            "${EndPoints.adImageUrl}${img.attachmentName}",
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: settingsCubit.locale == 'ar' ? 16 : null,
                                left: settingsCubit.locale == 'ar' ? null : 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.image,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      6.toWidth,
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: TextWidget(
                                          text:
                                              '${adDetailsCubit.currentPage + 1} / ${adDetails.images!.length}',
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -16,
                                right: settingsCubit.locale == 'ar' ? null : 16,
                                left: settingsCubit.locale == 'ar' ? 16 : null,
                                child: Row(
                                  children: [
                                    // FavoriteWidget(adModel: adDetails),
                                    16.toWidth,
                                    ButtonWidget(
                                      borderRadius: 18,
                                      showElevation: true,
                                      height: 0,
                                      width: 0,
                                      onTap: () {},
                                      color: Colors.white,
                                      child: const Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Icon(
                                          Icons.share_rounded,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 42,
                                right: settingsCubit.locale == 'ar' ? 6 : null,
                                left: settingsCubit.locale == 'ar' ? null : 6,
                                child: ButtonWidget(
                                  borderRadius: 18,
                                  showElevation: true,
                                  height: 0,
                                  width: 0,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/icons/rightArrow.png',
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: context.height * 0.03),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            Align(
                              alignment: context.textAlignment,
                              child: Row(
                                children: [
                                  TextWidget(
                                    isHaveOverflow: true,
                                    text: Formatter.formatNumber(
                                        //adModel.price
                                        BlocProvider.of<SettingsCubit>(context)
                                            .convertToAppCurrency(
                                                adCurrencyCode:
                                                    adDetails.currency!,
                                                adPrice: adDetails.price!)),
                                    fontSize: 18,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  6.toWidth,
                                  TextWidget(
                                    isHaveOverflow: true,
                                    text: getIt<CacheHelper>()
                                        .getDataString(key: 'currencyCode')!,
                                    fontSize: 18,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                            6.toHeight,
                            Align(
                              alignment: context.textAlignment,
                              child: TextWidget(
                                isHaveOverflow: true,
                                text: adDetails.adTitle!,
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            4.toHeight,
                            Visibility(
                              visible: [12, 26, 8, 27, 18, 14]
                                  .contains(adDetails.categoryId),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/bed.png',
                                      height: 20,
                                      width: 20,
                                      color: Colors.black,
                                    ),
                                    6.toWidth,
                                    Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: TextWidget(
                                        isHaveOverflow: true,
                                        text: adDetails.data.info!.roomCount
                                                .toString() +
                                            ' ' +
                                            S.of(context).Room,
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    12.toWidth,
                                    Image.asset(
                                      'assets/icons/bath.png',
                                      height: 20,
                                      width: 20,
                                      color: Colors.black,
                                    ),
                                    6.toWidth,
                                    Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: TextWidget(
                                        isHaveOverflow: true,
                                        text: adDetails.data.info!.bathroomCount
                                                .toString() +
                                            ' ' +
                                            S.of(context).Bathroom,
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    12.toWidth,
                                    Image.asset(
                                      'assets/icons/ruler.png',
                                      height: 20,
                                      width: 20,
                                      color: Colors.black,
                                    ),
                                    6.toWidth,
                                    Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: TextWidget(
                                        isHaveOverflow: true,
                                        text: adDetails.data.info!.totalArea
                                                .toString() +
                                            ' ' +
                                            S.of(context).SquareMeter,
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ), //حي أبو رمانة - شارع الجلاء
                              ),
                            ),
                            Visibility(
                              visible: ![12, 26, 8, 27, 18, 14]
                                  .contains(adDetails.categoryId),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/ruler.png',
                                    height: 20,
                                    width: 20,
                                    color: Colors.black,
                                  ),
                                  6.toWidth,
                                  Padding(
                                    padding: EdgeInsets.only(top: 6),
                                    child: TextWidget(
                                      isHaveOverflow: true,
                                      text: adDetails.data.info!.totalArea
                                              .toString() +
                                          ' ' +
                                          S.of(context).SquareMeter,
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            8.toHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: Colors.black,
                                ),
                                Expanded(
                                  child: TextWidget(
                                    textAlign: TextAlign.right,
                                    text:
                                        '${adDetails.data.info!.address ?? ''} ,${adDetails.data.city!.cityName} ,${adDetails.data.district!.districtName}',
                                    fontSize: 14,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            8.toHeight,
                            const Divider(),
                            8.toHeight,
                            Table(
                              columnWidths: {
                                0: FixedColumnWidth(
                                    context.width * 0.47), // عرض العمود الأول
                              },
                              children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: 'نوع:', // totalPrice!,
                                          fontSize: 16,
                                          //  fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: TextWidget(
                                          text: settingsCubit.getCategoryName(
                                              adDetails
                                                  .categoryId!)!, // totalPrice!,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text:
                                              'الغرض من الاعلان:', // totalPrice!,
                                          fontSize: 16,
                                          //  fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: TextWidget(
                                          text: settingsCubit
                                              .isForSale(adDetails.categoryId!),

                                          // totalPrice!,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: TextWidget(
                                          text:
                                              'مفروشة/غير مفروشة:', // totalPrice!,
                                          fontSize: 16,
                                          //  fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: TextWidget(
                                          text: adDetails.data.info!.furnish ==
                                                  'yes'
                                              ? S.current.Furnished
                                              : S.current.Unfurnished,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: 'صاعب الاعلان:', // totalPrice!,
                                          fontSize: 16,
                                          //  fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: TextWidget(
                                          text: adDetails.sellerType == 1
                                              ? S.current.Owner
                                              : S.current.Agent, // totalPrice!,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: 'صافي المساحة:', // totalPrice!,
                                          fontSize: 16,
                                          //  fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: TextWidget(
                                          text:
                                              '${adDetails.data.info!.totalArea}'
                                              ' ${S.of(context).SquareMeter}',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ![12, 26, 8, 27, 18, 14]
                                        .contains(adDetails.categoryId)
                                    ? TableRow(
                                        children: [SizedBox(), SizedBox()])
                                    : TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Container(
                                              alignment: context
                                                  .textAlignment, // محاذاة النص إلى اليسار
                                              child: TextWidget(
                                                text:
                                                    'رقم الطابق:', // totalPrice!,
                                                fontSize: 16,
                                                //  fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Container(
                                              alignment: context
                                                  .textAlignment, // محاذاة النص إلى اليسار
                                              child: TextWidget(
                                                text: adDetails.data.info!
                                                            .floorNumber ==
                                                        null
                                                    ? S.of(context).undefined
                                                    : adDetails
                                                        .data.info!.floorNumber
                                                        .toString(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                ![12, 26, 8, 27, 18, 14]
                                        .contains(adDetails.categoryId)
                                    ? TableRow(
                                        children: [SizedBox(), SizedBox()])
                                    : TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Container(
                                              alignment: context
                                                  .textAlignment, // محاذاة النص إلى اليسار
                                              child: const TextWidget(
                                                text:
                                                    'عدد الشرف:', // totalPrice!,
                                                fontSize: 16,
                                                //  fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Container(
                                              alignment: context
                                                  .textAlignment, // محاذاة النص إلى اليسار
                                              child: TextWidget(
                                                text: adDetails.data.info!
                                                            .balconyCount ==
                                                        null
                                                    ? S.of(context).undefined
                                                    : adDetails
                                                        .data.info!.balconyCount
                                                        .toString(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                ![12, 26, 8, 27, 18, 14]
                                        .contains(adDetails.categoryId)
                                    ? TableRow(
                                        children: [SizedBox(), SizedBox()])
                                    : TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Container(
                                              alignment: context
                                                  .textAlignment, // محاذاة النص إلى اليسار
                                              child: const TextWidget(
                                                text:
                                                    'اسم البناء:', // totalPrice!,
                                                fontSize: 16,
                                                //  fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Container(
                                              alignment: context
                                                  .textAlignment, // محاذاة النص إلى اليسار
                                              child: TextWidget(
                                                text: adDetails.data.info!
                                                            .complexName ==
                                                        ''
                                                    ? S.current.undefined
                                                    : adDetails.data.info!
                                                        .complexName!,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: const TextWidget(
                                          text: 'تاريخ النشر:', // totalPrice!,
                                          fontSize: 16,
                                          //  fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: context
                                            .textAlignment, // محاذاة النص إلى اليسار
                                        child: TextWidget(
                                          text:
                                              adDetails.publishDate.toString(),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                alignment: context.textAlignment,
                                child: const TextWidget(
                                  text: 'وصف الاعلان:', // totalPrice!,
                                  fontSize: 16,
                                  //  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            BlocBuilder<AdDetailsCubit, AdDetailsState>(
                              builder: (context, state) {
                                return TextWidget(
                                  maxLines: adDetailsCubit.descriptionIsExpanded
                                      ? null
                                      : 3,
                                  textAlign: TextAlign.justify,
                                  text: adDetails.description ??
                                      S.of(context).undefined,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                );
                              },
                            ),
                            8.toHeight,
                            BlocBuilder<AdDetailsCubit, AdDetailsState>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        adDetailsCubit
                                            .descriptionIsExpandedFunction();
                                      },
                                      child: TextWidget(
                                        text:
                                            adDetailsCubit.descriptionIsExpanded
                                                ? 'عرض أقل'
                                                : 'قراءة المزيد',
                                        color: Colors.blue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            8.toHeight,
                            const Divider(),
                            8.toHeight,
                            Align(
                              alignment: context.textAlignment,
                              child: const TextWidget(
                                isHaveOverflow: true,
                                text: 'مزايا العقار',
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            8.toHeight,
                            BlocBuilder<AdDetailsCubit, AdDetailsState>(
                              builder: (context, state) {
                                return GridView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: adDetailsCubit.showAllFeatures ||
                                          totalFeatures <= 8
                                      ? totalFeatures
                                      : 9,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1.1,
                                  ),
                                  itemBuilder: (context, index) {
                                    if (index < 8 && index < totalFeatures) {
                                      return ButtonWidget(
                                        color: Colors.grey[200]!,
                                        height: 0,
                                        width: 0,
                                        onTap: () {},
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                IconHelper.getIconPath(adDetails
                                                    .features![index]
                                                    .featureId),
                                                height: 25,
                                                width: 25),
                                            8.toHeight,
                                            // TextWidget(
                                            //   text: features[
                                            //       index], // عرض الميزات من البيانات
                                            // ),
                                          ],
                                        ),
                                      );
                                    } else if (index == 8 &&
                                        !adDetailsCubit.showAllFeatures) {
                                      // زر "عرض المزيد" عند الـ index == 8
                                      int remainingFeatures = totalFeatures - 8;
                                      return ButtonWidget(
                                        onTap: () {
                                          adDetailsCubit
                                              .showAllFeaturesFunction();
                                        },
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.more_horiz,
                                            ),
                                            8.toHeight,
                                            TextWidget(
                                              text:
                                                  '+$remainingFeatures مزايا إضافية',
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (index >= 8 &&
                                        adDetailsCubit.showAllFeatures) {
                                      return ButtonWidget(
                                        color: Colors.grey[200]!,
                                        height: 0,
                                        width: 0,
                                        onTap: () {},
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.ac_unit_outlined,
                                            ),
                                            8.toHeight,
                                            // TextWidget(
                                            //   text: features[
                                            //       index], // عرض الميزات المتبقية من نفس البيانات
                                            // ),
                                          ],
                                        ),
                                      );
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            8.toHeight,
                            const Divider(),
                            8.toHeight,
                            Align(
                              alignment: context.textAlignment,
                              child: const TextWidget(
                                isHaveOverflow: true,
                                text: 'عرض الخريطة',
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            8.toHeight,
                            Align(
                              alignment: context.textAlignment,
                              child: TextWidget(
                                // maxLines: 5,
                                textAlign: TextAlign.right,
                                text:
                                    '${adDetails.data.info!.address} ,${adDetails.data.city!.cityName} ,${adDetails.data.district!.districtName}',
                                fontSize: 14,
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            8.toHeight,
                            ButtonWidget(
                              height: 0.2,
                              width: 1,
                              onTap: () {},
                              child: FlutterMap(
                                key: mapKey,
                                options: MapOptions(
                                  initialCenter: settingsCubit
                                      .parseLatLng(adDetails.location!),
                                ),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    userAgentPackageName: 'com.example.app',
                                  ),
                                  MarkerLayer(
                                    markers: [
                                      Marker(
                                        point: settingsCubit
                                            .parseLatLng(adDetails.location!),
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
                            8.toHeight,
                            ButtonWidget(
                              color: AppColors.primary,
                              height: 0.05,
                              width: 1,
                              onTap: () async {
                                //  void openMaps(LatLng location) async {
                                // تحويل النص إلى Uri
                                final Uri url = Uri.parse(
                                    'https://www.google.com/maps?q=${settingsCubit.parseLatLng(adDetails.location!).latitude},${settingsCubit.parseLatLng(adDetails.location!).longitude}');

                                // التحقق من إمكانية فتح الرابط باستخدام canLaunchUrl
                                if (await canLaunchUrl(url)) {
                                  // فتح الرابط باستخدام launchUrl
                                  await launchUrl(url,
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  throw 'Could not open maps: $url';
                                }
                                // }
                              },
                              text: 'عرض الخريطة',
                            ),
                            4.toHeight,
                            const Divider(),
                            8.toHeight,
                            Align(
                              alignment: context.textAlignment,
                              child: const TextWidget(
                                isHaveOverflow: true,
                                text: 'معلومات صاحب الاعلان',
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            12.toHeight,
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/user.png',
                                    width: 80,
                                    height: 80,
                                  ),
                                  8.toHeight,
                                  TextWidget(
                                    text:
                                        '${adDetails.data.client!.firstName} ${adDetails.data.client!.lastName}',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  4.toHeight,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const TextWidget(
                                        text: 'عرض جميع العقارات',
                                        fontSize: 14,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      4.toWidth,
                                      const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 20,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            8.toHeight,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ButtonWidget(
                boxShadowOpacity: 0.7,
                borderRadius: 0,
                color: Colors.white,
                height: 0.1,
                width: 1,
                showElevation: true,
                onTap: () {},
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWidget(
                        borderRadius: 4,
                        onTap: () {},
                        height: 0.05,
                        width: 0.3,
                        color: const Color(0XDD64b5f6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                            8.toWidth,
                            const Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: TextWidget(
                                text: 'ايميل',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ButtonWidget(
                        borderRadius: 4,
                        onTap: () {},
                        height: 0.05,
                        width: 0.3,
                        color: const Color(0XDDe57373),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.phone_outlined,
                              color: Colors.white,
                            ),
                            8.toWidth,
                            const Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: TextWidget(
                                text: 'اتصال',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ButtonWidget(
                        borderRadius: 4,
                        onTap: () {},
                        height: 0.05,
                        width: 0.3,
                        color: const Color(0XFFa5d6a7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/whatsapp.png',
                              height: 20,
                              width: 20,
                              color: Colors.white,
                            ),
                            8.toWidth,
                            const Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: TextWidget(
                                text: 'واتساب',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          BlocBuilder<AdDetailsCubit, AdDetailsState>(
            builder: (context, state) {
              return adDetailsCubit.showAppBar == false
                  ? const SizedBox()
                  : Positioned(
                      top: 0,
                      child: ButtonWidget(
                        boxShadowOpacity: 0.1,
                        borderRadius: 0,
                        color: Colors.white,
                        height: 0.125,
                        width: 1,
                        showElevation: true,
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0,
                              right: 16,
                              top: context.height * 0.06,
                              bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                  8.toWidth,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          TextWidget(
                                            isHaveOverflow: true,
                                            text: Formatter.formatNumber(
                                                //adModel.price
                                                BlocProvider.of<SettingsCubit>(
                                                        context)
                                                    .convertToAppCurrency(
                                                        adCurrencyCode:
                                                            adDetails.currency!,
                                                        adPrice:
                                                            adDetails.price!)),
                                            fontSize: 16,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          6.toWidth,
                                          TextWidget(
                                            isHaveOverflow: true,
                                            text: getIt<CacheHelper>()
                                                .getDataString(
                                                    key: 'currencyCode')!,
                                            // Formatter.convertCurrencySymbol(
                                            //     adModel.currency),
                                            fontSize: 16,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      2.toHeight,
                                      ![12, 26, 8, 27, 18, 14]
                                              .contains(adDetails.categoryId)
                                          ? TextWidget(
                                              isHaveOverflow: true,
                                              text:
                                                  '${S.current.Area} ${adDetails.data.info!.totalArea} ${S.of(context).SquareMeter}',
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            )
                                          : TextWidget(
                                              isHaveOverflow: true,
                                              text:
                                                  '${adDetails.data.info!.roomCount} ${S.of(context).Room}  '
                                                  '${adDetails.data.info!.bathroomCount} ${S.of(context).Bathroom}  '
                                                  '${adDetails.data.info!.totalArea} ${S.of(context).SquareMeter}',
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                              ButtonWidget(
                                borderRadius: 18,
                                showElevation: true,
                                height: 0,
                                width: 0,
                                onTap: () {},
                                color: Colors.white,
                                child: const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Icon(
                                    Icons.share_rounded,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';

import 'package:emtelek/core/extensions/alignment_extension.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/shared/cubits/ad_details_cubit/ad_details_cubit.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/helper/features_icon.dart';
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
  final AdsModel? adsModel;

  PropertyDetailsPage({
    super.key,
    this.adsModel,
  });

  final int totalImages = 8;

  final Key mapKey = UniqueKey();

  final ScrollController scrollController = ScrollController();

  final List<String> imageUrls = [
    'assets/images/example.png',
    'assets/images/example1.webp',
    'assets/images/example2.webp',
    'assets/images/example3.webp',
    'assets/images/example.png',
    'assets/images/example1.webp',
    'assets/images/example2.webp',
    'assets/images/example3.webp',
  ];

  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    AdDetailsCubit adDetailsCubit = BlocProvider.of<AdDetailsCubit>(context);
    adDetailsCubit.showAppBarFunction(scrollController);
    final int totalFeatures =
        adsModel!.features == null ? 0 : adsModel!.features!.length;

    final List<String> features = List.generate(adsModel!.features!.length,
        (index) => '${adsModel!.features?[index].featureName}');
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
                                  pageTransition(context,
                                      page: const ImageGalleryPage());
                                },
                                child: SizedBox(
                                    height: context.height * 0.34,
                                    child: ImageSlideshow(
                                      indicatorColor: AppColors.primary,
                                      onPageChanged: (value) {
                                        adDetailsCubit
                                            .currentPageFunction(value);
                                      },
                                      children: imageUrls
                                          .map(
                                            (imageUrl) => Image.asset(
                                              imageUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                          .toList(),
                                    )),
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
                                              '${adDetailsCubit.currentPage + 1} / $totalImages',
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
                                          Icons.favorite_border,
                                          size: 22,
                                        ),
                                      ),
                                    ),
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
                                    text: adsModel == null
                                        ? '0000'
                                        : adsModel!.price.toStringAsFixed(2),
                                    fontSize: 18,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  6.toWidth,
                                  TextWidget(
                                    isHaveOverflow: true,
                                    text: adsModel == null
                                        ? 'ل.س'
                                        : adsModel!.currency,
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
                                text: adsModel == null
                                    ? 'منزل مستقل 4 غرف وصالة'
                                    : adsModel!.adTitle,
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            4.toHeight,
                            Align(
                              alignment: context.textAlignment,
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
                                      text: adsModel == null
                                          ? '4' ' ${S.of(context).Room}'
                                          : '${adsModel!.roomCount}'
                                              ' ${S.of(context).Room}',
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
                                    padding: const EdgeInsets.only(top: 6),
                                    child: TextWidget(
                                      isHaveOverflow: true,
                                      text: adsModel == null
                                          ? '4' ' ${S.of(context).Bathroom}'
                                          : '${adsModel!.bathroomCount}'
                                              ' ${S.of(context).Bathroom}',
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
                                      text: adsModel == null
                                          ? '224'
                                              ' ${S.of(context).SquareMeter}'
                                          : '${adsModel!.totalArea}'
                                              ' ${S.of(context).SquareMeter}',
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ), //حي أبو رمانة - شارع الجلاء
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
                                    text: adsModel == null
                                        ? 'شارع الجلاء ,حي أبو رمانة ,منطقة الصالحية ,مدينة دمشق'
                                        : '${adsModel!.address} ,${adsModel!.cityName} ,${adsModel!.districtName}',
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
                                          text: adsModel == null
                                              ? 'شقة'
                                              : settingsCubit.getCategoryName(
                                                  adsModel!
                                                      .categoryId)!, // totalPrice!,
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
                                          text: adsModel == null
                                              ? 'الايجار'
                                              : settingsCubit.isForSale(
                                                  adsModel!.categoryId),

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
                                          text: adsModel == null
                                              ? 'غير مفروشة'
                                              : adsModel!.furnish == true
                                                  ? 'مفروشة'
                                                  : 'غير مفروشة',
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
                                          text: adsModel == null
                                              ? 'مالك'
                                              : adsModel!.sellerType == 1
                                                  ? S.current.Owner
                                                  : S.current
                                                      .Agent, // totalPrice!,
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
                                          text: adsModel == null
                                              ? '224'
                                                  ' ${S.of(context).SquareMeter}'
                                              : '${adsModel!.totalArea}'
                                                  ' ${S.of(context).SquareMeter}',
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
                                          text: 'رقم الطابق:', // totalPrice!,
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
                                          text: adsModel == null
                                              ? '3'
                                              : adsModel!.floorNumber
                                                  .toString(),
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
                                          text: 'عدد الشرف:', // totalPrice!,
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
                                          text: adsModel == null
                                              ? '3'
                                              : adsModel!.balconyCount
                                                  .toString(),
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
                                          text: 'اسم البناء:', // totalPrice!,
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
                                          text: adsModel == null
                                              ? 'بناء 1'
                                              : adsModel!.complexName
                                                  .toString(), // totalPrice!,
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
                                          text: adsModel == null
                                              ? '2022-01-01'
                                              : adsModel!.publishDate
                                                  .toString(), // totalPrice!,
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
                                alignment: context
                                    .textAlignment, // محاذاة النص إلى اليسار
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
                                      : 3, // عرض النص كاملاً إذا كان موسعاً
                                  textAlign: TextAlign.justify,
                                  text: adsModel == null
                                      ? 'شقة فاخرة تقع في قلب المدينة، تتميز بإطلالات بانورامية خلابة على الأفق. تضم ثلاث غرف نوم واسعة، وصالة مشرقة مع نوافذ كبيرة تسمح بدخول الضوء الطبيعي. المطبخ مصمم بأحدث الأجهزة والتشطيبات العصرية. تحتوي الشقة أيضًا على حمامين أنيقين مجهزين بالكامل. توفر مجمع سكني آمن مع خدمات مميزة مثل حوض سباحة، نادي رياضي، ومواقف خاصة للسيارات. تقع بالقرب من المدارس، المتاجر، والمرافق العامة، مما يجعلها مثالية للعائلات. فرصة استثمارية رائعة لمحبي الفخامة والراحة.'
                                      : adsModel!.description.toString(),
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
                                  physics:
                                      const NeverScrollableScrollPhysics(), // إيقاف التمرير
                                  itemCount: adDetailsCubit.showAllFeatures ||
                                          totalFeatures <= 8
                                      ? totalFeatures // عرض جميع الميزات إذا كانت أقل من 8 أو تم الضغط على زر "عرض المزيد"
                                      : 9, // عرض 8 ميزات مع زر "عرض المزيد" في النهاية
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1.1,
                                  ),
                                  itemBuilder: (context, index) {
                                    if (index < 8 && index < totalFeatures) {
                                      // عرض الميزات فقط إذا كانت موجودة
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
                                                IconHelper.getIconPath(adsModel!
                                                    .features![index]
                                                    .featureId),
                                                height: 25,
                                                width: 25),
                                            8.toHeight,
                                            TextWidget(
                                              text: features[
                                                  index], // عرض الميزات من البيانات
                                            ),
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
                                      // عرض الميزات المتبقية مع زر "عرض أقل"
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
                                            TextWidget(
                                              text: features[
                                                  index], // عرض الميزات المتبقية من نفس البيانات
                                            ),
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
                                text: adsModel == null
                                    ? 'شارع الجلاء ,حي أبو رمانة ,منطقة الصالحية ,مدينة دمشق'
                                    : '${adsModel!.address} ,${adsModel!.cityName} ,${adsModel!.districtName}',
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
                                      .parseLatLng(adsModel!.location),
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
                                            .parseLatLng(adsModel!.location),
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
                                    'https://www.google.com/maps?q=${settingsCubit.parseLatLng(adsModel!.location).latitude},${settingsCubit.parseLatLng(adsModel!.location).longitude}');

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
                                    text: adsModel == null
                                        ? 'احمد عبد الرحيم'
                                        : '${adsModel!.firstName} ${adsModel!.lastName}',
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
                height: 0.07,
                width: 1,
                showElevation: true,
                onTap: () {},
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Row(
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
                                          const TextWidget(
                                            isHaveOverflow: true,
                                            text: '28,600,278',
                                            fontSize: 16,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          6.toWidth,
                                          const TextWidget(
                                            isHaveOverflow: true,
                                            text: 'ل.س',
                                            fontSize: 16,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      2.toHeight,
                                      Row(
                                        children: [
                                          const TextWidget(
                                            isHaveOverflow: true,
                                            text: '4 غرف',
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          6.toWidth,
                                          const TextWidget(
                                            isHaveOverflow: true,
                                            text: '2 الحمامات',
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          6.toWidth,
                                          const TextWidget(
                                            isHaveOverflow: true,
                                            text: '224 متر مربع',
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
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

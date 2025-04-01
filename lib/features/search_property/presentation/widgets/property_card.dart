import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/features/favorites/presentation/widgets/favorite_widget.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/features/search_property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/features/search_property/presentation/pages/property_details_page.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/common_pages/image_viewer_page.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    super.key,
    required this.index,
    required this.adsModel,
  });
  final int index;
  final List<AdsModel> adsModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pageTransition(context,
            page: PropertyDetailsPage(
              adsModel: adsModel[index],
              //adsModel[index],
            ));
      },
      child: Container(
        height: context.height * 0.47,
        width: context.width * 1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // لون الظل
              spreadRadius: 1, // مدى انتشار الظل
              blurRadius: 1, // مقدار الضبابية
              offset: const Offset(0, 2), // إزاحة الظل (x, y)
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                GestureDetector(
                  onTap: () {
                    pageTransition(context, page: PropertyDetailsPage());
                  },
                  child: SizedBox(
                    height: context.height * 0.25,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: Image.asset(
                          'assets/images/example.png',
                        )),
                  ),
                ),
                FavoriteWidget(
                  adsModel: adsModel[index],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 12, bottom: 8),
              child: Column(children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      TextWidget(
                        isHaveOverflow: true,
                        text: adsModel[index].price.toString(),
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                      6.toWidth,
                      TextWidget(
                        isHaveOverflow: true,
                        text: adsModel[index].currency.toString(),
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                6.toHeight,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextWidget(
                    isHaveOverflow: true,
                    text: adsModel[index].adTitle.toString(),
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.toHeight,
                Align(
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
                          text: adsModel[index].roomCount.toString() +
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
                          text: adsModel[index].bathroomCount.toString() +
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
                          text: adsModel[index].totalArea.toString() +
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
                12.toHeight,
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
                        text: adsModel[index].address.toString() +
                            ' , ' +
                            adsModel[index].districtName.toString() +
                            ' , ' +
                            adsModel[index].cityName.toString(),

                        fontSize: 14,
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                16.toHeight,
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWidget(
                        borderRadius: 4,
                        onTap: () {},
                        height: 0.05,
                        width: 0.42,
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
                        width: 0.42,
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
                    ])
              ]),
            )
          ],
        ),
      ),
    );
  }
}

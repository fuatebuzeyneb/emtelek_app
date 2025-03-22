import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/features/search_property/presentation/pages/property_details_page.dart';
import 'package:emtelek/shared/common_pages/image_viewer_page.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class PropertyCard extends StatefulWidget {
  const PropertyCard({
    super.key,
  });

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  int currentPage = 0;
  final int totalImages = 8;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pageTransition(context, page: PropertyDetailsPage());
      },
      child: Container(
        height: context.height * 0.51,
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
                    height: context.height * 0.27,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: ImageSlideshow(
                        indicatorColor: AppColors.primary,
                        onPageChanged: (value) {
                          setState(() {
                            currentPage = value;
                          });
                        },
                        children: [
                          Image.asset(
                            'assets/images/example.png',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'assets/images/example1.webp',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'assets/images/example2.webp',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'assets/images/example3.webp',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'assets/images/example.png',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'assets/images/example1.webp',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'assets/images/example2.webp',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'assets/images/example3.webp',
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.image,
                          size: 14,
                          color: Colors.white,
                        ),
                        6.toWidth,
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: TextWidget(
                            text: '${currentPage + 1} / $totalImages',
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 8,
                  child: ButtonWidget(
                    borderRadius: 18,
                    showElevation: true,
                    height: 0,
                    width: 0,
                    onTap: () {},
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.favorite_border,
                        size: 20,
                      ),
                    ),
                  ),
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
                      const TextWidget(
                        isHaveOverflow: true,
                        text: '28,600,278',
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                      6.toWidth,
                      const TextWidget(
                        isHaveOverflow: true,
                        text: 'ل.س',
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                6.toHeight,
                const Align(
                  alignment: Alignment.centerRight,
                  child: TextWidget(
                    isHaveOverflow: true,
                    text: 'منزل مستقل 4 غرف وصالة',
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
                      const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: TextWidget(
                          isHaveOverflow: true,
                          text: '4 غرف',
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
                      const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: TextWidget(
                          isHaveOverflow: true,
                          text: '2 الحمامات',
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
                      const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: TextWidget(
                          isHaveOverflow: true,
                          text: '224 متر مربع',
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ), //حي أبو رمانة - شارع الجلاء
                ),
                12.toHeight,
                const Row(
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
                            'شارع الجلاء ,حي أبو رمانة ,منطقة الصالحية ,مدينة دمشق',
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

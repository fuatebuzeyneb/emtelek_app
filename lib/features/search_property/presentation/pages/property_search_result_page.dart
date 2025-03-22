import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/search_property/presentation/widgets/bottom_sheets/property_bathroom_count_bottom_sheet.dart';
import 'package:emtelek/features/search_property/presentation/widgets/bottom_sheets/property_price_input_bottom_sheet.dart';
import 'package:emtelek/features/search_property/presentation/widgets/bottom_sheets/property_rent_or_sale_bottom_sheet.dart';
import 'package:emtelek/features/search_property/presentation/widgets/bottom_sheets/property_room_count_bottom_sheet.dart';

import 'package:emtelek/features/search_property/presentation/widgets/bottom_sheets/property_type_bottom_sheet.dart';
import 'package:emtelek/features/search_property/presentation/widgets/property_card.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PropertySearchResultPage extends StatelessWidget {
  const PropertySearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'text': 'للايجار',
        'onTap': () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // يسمح بالتحكم الكامل في الطول
            enableDrag: false,

            builder: (context) {
              return const PropertyRentOrSaleBottomSheet();
            },
          );
        },
      },
      {
        'text': 'شقة',
        'onTap': () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // يسمح بالتحكم الكامل في الطول
            enableDrag: false,

            builder: (context) {
              return const PropertyTypeBottomSheet();
            },
          );
        },
      },
      {
        'text': 'السعر',
        'onTap': () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // يسمح بالتحكم الكامل في الطول
            enableDrag: false,

            builder: (context) {
              return const PropertyPriceInputBottomSheet();
            },
          );
        },
      },
      {
        'text': 'غرف النوم',
        'onTap': () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // يسمح بالتحكم الكامل في الطول
            enableDrag: false,

            builder: (context) {
              return const PropertyRoomCountBottomSheet();
            },
          );
        },
      },
      {
        'text': 'عدد الحمامات',
        'onTap': () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // يسمح بالتحكم الكامل في الطول
            enableDrag: false,

            builder: (context) {
              return const PropertyBathroomCountBottomSheet();
            },
          );
        },
      },
    ];
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          ButtonWidget(
            borderRadius: 0,
            showElevation: true,
            boxShadowOpacity: 0.1,
            height: 0.2,
            width: 1,
            onTap: () {},
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        ),
                      ),
                      8.toWidth,
                      ButtonWidget(
                        onTap: () {},
                        color: Colors.white,
                        height: 0.06,
                        width: 0.86,
                        colorText: Colors.grey,
                        borderColor: Colors.grey,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20,
                              ),
                              SizedBox(width: 4),
                              TextWidget(
                                text: 'دمشق، اللاذقية، ادلب، سراقب، بانياس',
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                12.toHeight,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.tune,
                          color: AppColors.primary,
                          size: 24,
                        ),
                        8.toWidth,
                        TextWidget(
                          text: 'فلتر',
                          fontSize: 16,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        4.toWidth,
                        ButtonWidget(
                          paddingHorizontal: 8,
                          paddingVertical: 2,
                          borderRadius: 16,
                          onTap: () {},
                          color: Colors.black,
                          height: 0,
                          width: 0,
                          colorText: Colors.white,
                          borderColor: Colors.black,
                          text: '2',
                        ),
                        8.toWidth,
                        SizedBox(
                          height: context.height * 0.04,
                          width: context.width * 1.32,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 0),
                                child: ButtonWidget(
                                  onTap: items[index]['onTap'],
                                  color: (index == 0 || index == 1)
                                      ? Colors.grey.shade200
                                      : Colors.white,
                                  height: 0,
                                  width: 0,
                                  borderColor: (index == 0 || index == 1)
                                      ? Colors.black
                                      : Colors.grey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      children: [
                                        TextWidget(
                                          text: items[index]['text'],
                                          fontSize: 14,
                                          color: (index == 0 || index == 1)
                                              ? Colors.black
                                              : Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 20,
                                          color: (index == 0 || index == 1)
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const TextWidget(
                          text: 'كل الفلاتر',
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        2.toWidth,
                        SizedBox(
                          height: context.height * 0.025,
                          child: const VerticalDivider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                        ),
                        2.toWidth,
                        const TextWidget(
                          text: 'كل الفلاتر',
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
                12.toHeight,
              ],
            ),
          ),
          16.toHeight,
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: PropertyCard(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

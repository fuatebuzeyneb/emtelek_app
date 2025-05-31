import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/auth/presentation/widgets/bottom_sheets/login_options_bottom_sheet.dart';
import 'package:emtelek/features/property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/features/property_filter/presentation/widgets/bottom_sheets/property_bathroom_count_bottom_sheet.dart';
import 'package:emtelek/features/property_filter/presentation/widgets/bottom_sheets/property_price_input_bottom_sheet.dart';
import 'package:emtelek/features/property_filter/presentation/widgets/bottom_sheets/property_rent_or_sale_bottom_sheet.dart';
import 'package:emtelek/features/property_filter/presentation/widgets/bottom_sheets/property_room_count_bottom_sheet.dart';
import 'package:emtelek/features/property_filter/presentation/widgets/bottom_sheets/property_save_search_bottom_sheet.dart';

import 'package:emtelek/features/property_filter/presentation/widgets/bottom_sheets/property_type_bottom_sheet.dart';
import 'package:emtelek/features/property_filter/presentation/widgets/property_card.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/loading_widget.dart';
import 'package:emtelek/shared/widgets/sort_alert_dialog_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class PropertySearchResultPage extends StatelessWidget {
//   const PropertySearchResultPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     PropertyCubit propertyCubit = BlocProvider.of<PropertyCubit>(context);
//     SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);

//     return Scaffold(
//         backgroundColor: Colors.grey.shade200,
//         body: Column(
//           children: [
//             ButtonWidget(
//               borderRadius: 0,
//               showElevation: true,
//               boxShadowOpacity: 0.1,
//               height: 0.24,
//               width: 1,
//               onTap: () {},
//               color: Colors.white,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Icon(
//                             Icons.arrow_back_ios,
//                             size: 20,
//                           ),
//                         ),
//                         8.toWidth,
//                         ButtonWidget(
//                           onTap: () {},
//                           color: Colors.white,
//                           height: 0.06,
//                           width: 0.86,
//                           colorText: Colors.grey,
//                           borderColor: Colors.grey,
//                           child: const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 8),
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.location_on,
//                                   size: 20,
//                                 ),
//                                 SizedBox(width: 4),
//                                 TextWidget(
//                                   text: 'دمشق، اللاذقية، ادلب، سراقب، بانياس',
//                                   fontSize: 12,
//                                   color: Colors.grey,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   12.toHeight,
//                   BlocConsumer<PropertyCubit, PropertyState>(
//                     listener: (context, state) {
//                       // TODO: implement listener
//                     },
//                     builder: (context, state) {
//                       final List<Map<String, dynamic>> items = [
//                         {
//                           'text':
//                               propertyCubit.adType == 6 ? 'للبيع' : 'للايجار',
//                           'onTap': () {
//                             showModalBottomSheet(
//                               context: context,
//                               isScrollControlled:
//                                   true, // يسمح بالتحكم الكامل في الطول
//                               enableDrag: false,

//                               builder: (context) {
//                                 return const PropertyRentOrSaleBottomSheet();
//                               },
//                             );
//                           },
//                         },
//                         {
//                           'text': propertyCubit.adType == 6
//                               ? '${settingsCubit.saleCategories[propertyCubit.propertyType]}'
//                               : '${settingsCubit.rentCategories[propertyCubit.propertyType]}',
//                           'onTap': () {
//                             showModalBottomSheet(
//                               context: context,
//                               isScrollControlled:
//                                   true, // يسمح بالتحكم الكامل في الطول
//                               enableDrag: false,

//                               builder: (context) {
//                                 return const PropertyTypeBottomSheet();
//                               },
//                             );
//                           },
//                         },
//                         {
//                           'text': 'السعر',
//                           'onTap': () {
//                             showModalBottomSheet(
//                               context: context,
//                               isScrollControlled:
//                                   true, // يسمح بالتحكم الكامل في الطول
//                               enableDrag: false,

//                               builder: (context) {
//                                 return const PropertyPriceInputBottomSheet();
//                               },
//                             );
//                           },
//                         },
//                         {
//                           'text': 'غرف النوم',
//                           'onTap': () {
//                             showModalBottomSheet(
//                               context: context,
//                               isScrollControlled:
//                                   true, // يسمح بالتحكم الكامل في الطول
//                               enableDrag: false,

//                               builder: (context) {
//                                 return const PropertyRoomCountBottomSheet();
//                               },
//                             );
//                           },
//                         },
//                         {
//                           'text': 'عدد الحمامات',
//                           'onTap': () {
//                             showModalBottomSheet(
//                               context: context,
//                               isScrollControlled:
//                                   true, // يسمح بالتحكم الكامل في الطول
//                               enableDrag: false,

//                               builder: (context) {
//                                 return const PropertyBathroomCountBottomSheet();
//                               },
//                             );
//                           },
//                         },
//                       ];
//                       return SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.tune,
//                                 color: AppColors.primary,
//                                 size: 24,
//                               ),
//                               8.toWidth,
//                               TextWidget(
//                                 text: 'فلتر',
//                                 fontSize: 16,
//                                 color: AppColors.primary,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               4.toWidth,
//                               ButtonWidget(
//                                 paddingHorizontal: 8,
//                                 paddingVertical: 2,
//                                 borderRadius: 16,
//                                 onTap: () {},
//                                 color: Colors.black,
//                                 height: 0,
//                                 width: 0,
//                                 colorText: Colors.white,
//                                 borderColor: Colors.black,
//                                 text: '2',
//                               ),
//                               8.toWidth,
//                               SizedBox(
//                                 height: context.height * 0.04,
//                                 width: context.width * 1.2,
//                                 child: ListView.builder(
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   itemCount: 5,
//                                   scrollDirection: Axis.horizontal,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 8, right: 0),
//                                       child: ButtonWidget(
//                                         onTap: items[index]['onTap'],
//                                         color: (index == 0 || index == 1)
//                                             ? Colors.grey.shade200
//                                             : Colors.white,
//                                         height: 0,
//                                         width: 0,
//                                         borderColor: (index == 0 || index == 1)
//                                             ? Colors.black
//                                             : Colors.grey,
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 8),
//                                           child: Row(
//                                             children: [
//                                               TextWidget(
//                                                 text: items[index]['text'],
//                                                 fontSize: 14,
//                                                 color:
//                                                     (index == 0 || index == 1)
//                                                         ? Colors.black
//                                                         : Colors.grey,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                               const SizedBox(width: 4),
//                                               Icon(
//                                                 Icons.keyboard_arrow_down,
//                                                 size: 20,
//                                                 color:
//                                                     (index == 0 || index == 1)
//                                                         ? Colors.black
//                                                         : Colors.grey,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               const TextWidget(
//                                 text: 'كل الفلاتر',
//                                 fontSize: 14,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               2.toWidth,
//                               SizedBox(
//                                 height: context.height * 0.025,
//                                 child: const VerticalDivider(
//                                   color: Colors.grey,
//                                   thickness: 2,
//                                 ),
//                               ),
//                               2.toWidth,
//                               const TextWidget(
//                                 text: 'اعاده الضبط',
//                                 fontSize: 14,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   14.toHeight,
//                   ButtonWidget(
//                     height: 0.04,
//                     width: 1,
//                     onTap: () {},
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: ButtonWidget(
//                             color: Colors.white,
//                             onTap: () {
//                               showDialog<void>(
//                                 context: context,
//                                 barrierDismissible:
//                                     false, // user must tap button!
//                                 builder: (BuildContext context) {
//                                   return SortAlertDialogWidget();
//                                 },
//                               );
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.swap_vert),
//                                 4.toWidth,
//                                 TextWidget(
//                                   text: S.of(context).Sort,
//                                   fontSize: 16,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         VerticalDivider(
//                           color: Colors.grey,
//                           thickness: 2,
//                         ),
//                         Expanded(
//                           child: ButtonWidget(
//                             height: 0.04,
//                             width: 0.5,
//                             color: Colors.white,
//                             onTap: () {
//                               showModalBottomSheet(
//                                 context: context,
//                                 isScrollControlled:
//                                     true, // يسمح بالتحكم الكامل في الطول
//                                 enableDrag: false,

//                                 builder: (context) {
//                                   return const PropertySaveSearchBottomSheet();
//                                 },
//                               );
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.bookmark),
//                                 4.toWidth,
//                                 TextWidget(
//                                   text: S.of(context).SaveSearch,
//                                   fontSize: 16,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   6.toHeight,
//                 ],
//               ),
//             ),
//             16.toHeight,
//             BlocConsumer<PropertyCubit, PropertyState>(
//               listener: (context, state) {
//                 // TODO: implement listener
//               },
//               builder: (context, state) {
//                 return state is PropertyAdsFilterLoading
//                     ? Center(
//                         child: LoadingWidget(),
//                       )
//                     : state is PropertyAdsFilterFailure
//                         ? Center(
//                             child: Text(state.errMessage),
//                           )
//                         : Expanded(
//                             child: ListView.builder(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 8,
//                               ),
//                               itemCount: BlocProvider.of<PropertyCubit>(context)
//                                   .filteredAds
//                                   .length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return Padding(
//                                   padding: EdgeInsets.only(bottom: 16),
//                                   child: PropertyCard(
//                                     index: index,
//                                     adsModel:
//                                         BlocProvider.of<PropertyCubit>(context)
//                                             .filteredAds,
//                                   ),
//                                 );
//                               },
//                             ),
//                           );
//               },
//             )
//           ],
//         ));
//   }
// }

class PropertySearchResultPage extends StatefulWidget {
  const PropertySearchResultPage({super.key});

  @override
  State<PropertySearchResultPage> createState() =>
      _PropertySearchResultPageState();
}

class _PropertySearchResultPageState extends State<PropertySearchResultPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final propertyCubit = context.read<PropertyCubit>();
    final settingsCubit = context.read<SettingsCubit>();

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!propertyCubit.isFetchingMore && !propertyCubit.isFinished) {
        propertyCubit.fetchNextPage(
          listCityIds: settingsCubit.selectedCityIds,
          listDistrictIds: settingsCubit.selectedDistrictIds,
          minPrice: settingsCubit.minPrice?.toInt(),
          maxPrice: settingsCubit.maxPrice?.toInt(),
          sortBy: null,
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PropertyCubit propertyCubit = BlocProvider.of<PropertyCubit>(context);
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          // الجزء العلوي (الفلاتر + العنوان)
          ButtonWidget(
            borderRadius: 0,
            showElevation: true,
            boxShadowOpacity: 0.1,
            height: 0.24,
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
                        child: const Icon(Icons.arrow_back_ios, size: 20),
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
                              Icon(Icons.location_on, size: 20),
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
                // فلاتر البحث
                BlocConsumer<PropertyCubit, PropertyState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    final List<Map<String, dynamic>> items = [
                      {
                        'text': propertyCubit.adType == 6 ? 'للبيع' : 'للايجار',
                        'onTap': () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            enableDrag: false,
                            builder: (context) =>
                                const PropertyRentOrSaleBottomSheet(),
                          );
                        },
                      },
                      {
                        'text': propertyCubit.adType == 6
                            ? '${settingsCubit.saleCategories[propertyCubit.propertyType]}'
                            : '${settingsCubit.rentCategories[propertyCubit.propertyType]}',
                        'onTap': () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            enableDrag: false,
                            builder: (context) =>
                                const PropertyTypeBottomSheet(),
                          );
                        },
                      },
                      {
                        'text': 'السعر',
                        'onTap': () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            enableDrag: false,
                            builder: (context) =>
                                const PropertyPriceInputBottomSheet(),
                          );
                        },
                      },
                      {
                        'text': 'غرف النوم',
                        'onTap': () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            enableDrag: false,
                            builder: (context) =>
                                const PropertyRoomCountBottomSheet(),
                          );
                        },
                      },
                      {
                        'text': 'عدد الحمامات',
                        'onTap': () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            enableDrag: false,
                            builder: (context) =>
                                const PropertyBathroomCountBottomSheet(),
                          );
                        },
                      },
                    ];
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Icon(Icons.tune,
                                color: AppColors.primary, size: 24),
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
                              width: context.width * 1.2,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: items.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8),
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
                              text: 'اعاده الضبط',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                14.toHeight,
                ButtonWidget(
                  height: 0.04,
                  width: 1,
                  onTap: () {},
                  child: Row(
                    children: [
                      Expanded(
                        child: ButtonWidget(
                          color: Colors.white,
                          onTap: () {
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => SortAlertDialogWidget(),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.swap_vert),
                              4.toWidth,
                              TextWidget(
                                text: S.of(context).Sort,
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(color: Colors.grey, thickness: 2),
                      Expanded(
                        child: ButtonWidget(
                          height: 0.04,
                          width: 0.5,
                          color: Colors.white,
                          onTap: () {
                            if (getIt<CacheHelper>()
                                    .getDataString(key: 'token') !=
                                null) {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                enableDrag: false,
                                builder: (context) =>
                                    const PropertySaveSearchBottomSheet(),
                              );
                            } else {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                enableDrag: false,
                                builder: (context) =>
                                    const LoginOptionsBottomSheet(),
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.bookmark),
                              4.toWidth,
                              TextWidget(
                                text: S.of(context).SaveSearch,
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                6.toHeight,
              ],
            ),
          ),
          16.toHeight,
          // جزء النتائج
          // Expanded(
          //   child: BlocConsumer<PropertyCubit, PropertyState>(
          //     listener: (context, state) {},
          //     builder: (context, state) {
          //       if (state is PropertyAdsFilterLoading &&
          //           propertyCubit.filteredAds.isEmpty) {
          //         return const Center(child: LoadingWidget());
          //       } else if (state is PropertyAdsFilterFailure) {
          //         return Center(child: Text(state.errMessage));
          //       }

          //       return ListView.builder(
          //         controller: _scrollController,
          //         padding: const EdgeInsets.symmetric(horizontal: 8),
          //         itemCount: propertyCubit.filteredAds.length +
          //             (propertyCubit.isFetchingMore ? 1 : 0),
          //         itemBuilder: (context, index) {
          //           if (index < propertyCubit.filteredAds.length) {
          //             return Padding(
          //               padding: const EdgeInsets.only(bottom: 16),
          //               child: PropertyCard(
          //                 index: index,
          //                 adDetails: propertyCubit.filteredAds,
          //               ),
          //             );
          //           } else {
          //             return const Center(
          //               child: Padding(
          //                 padding: EdgeInsets.symmetric(vertical: 16),
          //                 child: CircularProgressIndicator(),
          //               ),
          //             );
          //           }
          //         },
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

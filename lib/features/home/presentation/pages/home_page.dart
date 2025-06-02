import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/core/utils/snackbar_utils.dart';
import 'package:emtelek/features/home/domain/cubit/home_cubit.dart';
import 'package:emtelek/features/property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/features/property_filter/domain/cubit/property_filter_cubit.dart';
import 'package:emtelek/shared/common_pages/search_text_page.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/features/property_filter/presentation/widgets/bottom_sheets/property_filter_bottom_sheet.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/loading_widget.dart';
import 'package:emtelek/shared/widgets/text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:emtelek/features/home/presentation/widgets/product_card_home_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PropertyFilterCubit propertyFilterCubit =
        BlocProvider.of<PropertyFilterCubit>(context);
    HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    homeCubit.startTimer();
    homeCubit.updateIconsAndTexts(
      findHomeText: S.of(context).FindHome,
      findCarText: S.of(context).FindCar,
      findOfficeText:
          S.of(context).FindOffice, // مثال إذا كنت تريد إضافة نصوص أخرى
      findLandText: S.of(context).FindLand,
    );
    final List<Map<String, dynamic>> cardsData = [
      {
        "title": S.of(context).PropertyForRent,
        "image": 'assets/icons/home.png',
        "onTap": () {
          propertyFilterCubit.changeAdType(5);
          propertyFilterCubit.changePropertyType(8);

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            enableDrag: false,
            builder: (context) {
              return const PropertyFilterBottomSheet();
            },
          );
        },
      },
      {
        "title": S.of(context).PropertyForSale,
        "image": 'assets/icons/home.png',
        "onTap": () {
          propertyFilterCubit.changeAdType(6);
          propertyFilterCubit.changePropertyType(14);

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            enableDrag: false,
            builder: (context) {
              return const PropertyFilterBottomSheet();
            },
          );
        },
      },
      {
        "title": S.of(context).Vehicles,
        "image": 'assets/icons/car.png',
        "onTap": () {
          SnackbarUtils.showSnackbar(
              context, 'Pressed Card 3 - Commercial Property', 3);
          print("Pressed Card 3 - Commercial Property");
        },
      },
    ];
    BlocProvider.of<SettingsCubit>(context).openBox();

    //homeCubit.getHomeData();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.height * 0.06),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      final homeCubit = context.read<HomeCubit>();
                      return SizedBox(
                        child: AnimatedSwitcher(
                          duration: const Duration(seconds: 1),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          child: Row(
                            key: ValueKey<int>(homeCubit.currentIndex),
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonWidget(
                                borderRadius: 12,
                                paddingHorizontal: 12,
                                borderColor: Colors.grey,
                                height: 0.05,
                                width: 0.85,
                                onTap: () {
                                  pageTransition(context,
                                      page: SearchTextPage());
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      homeCubit.currentIconAndText['image'],
                                      color: Colors.grey,
                                      height: 25,
                                      width: 25,
                                    ),
                                    10.toWidth,
                                    TextWidget(
                                      text:
                                          homeCubit.currentIconAndText['text'],
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const Icon(
                    Icons.notifications,
                    color: Colors.grey,
                    size: 26,
                  )
                ],
              ),
            ),
            20.toHeight,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                height: context.height * 0.14,
                width: context.width * 1,
                child: GridView.builder(
                  padding: const EdgeInsets.all(0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.1, //
                  ),
                  itemCount: cardsData.length,
                  itemBuilder: (context, index) {
                    final cardData = cardsData[index];
                    return ButtonWidget(
                      showElevation: true,
                      paddingVertical: 0,
                      paddingHorizontal: 0,
                      onTap: () {
                        cardData["onTap"]();
                      },
                      color: Colors.white,
                      height: 0,
                      width: 0,
                      //  borderColor: Colors.black12,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              cardData["image"],
                              width: 30,
                              height: 30,
                              color: AppColors.primary,
                            ),
                            8.toHeight,
                            TextWidget(
                              text: cardData["title"],
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
              ),
            ),
            12.toHeight,
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return state is HomeAdsLoading
                    ? const Center(
                        child: LoadingWidget(),
                      )
                    : state is HomeAdsFailure
                        ? Center(
                            child: TextWidget(
                              text: state.errorMassage,
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      text: S.of(context).MostVisitedInRentals,
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const Spacer(),
                                    TextWidget(
                                      text: S.of(context).ViewAll,
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                homeCubit.propertiesRent == null ||
                                        homeCubit.propertiesRent!.isEmpty
                                    ? SizedBox()
                                    : SizedBox(
                                        width: context.width * 1,
                                        height: context.height * 0.22,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              homeCubit.propertiesRent!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: ProductCardHomeWidget(
                                                property: homeCubit
                                                    .propertiesRent![index],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                16.toHeight,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      text: S.of(context).MostVisitedInSales,
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const Spacer(),
                                    TextWidget(
                                      text: S.of(context).ViewAll,
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                homeCubit.propertiesSell == null ||
                                        homeCubit.propertiesSell!.isEmpty
                                    ? SizedBox()
                                    : SizedBox(
                                        width: context.width * 1,
                                        height: context.height * 0.22,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              homeCubit.propertiesSell!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: ProductCardHomeWidget(
                                                property: homeCubit
                                                    .propertiesSell![index],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              ],
                            ),
                          );
              },
            )
          ],
        ),
      ),
    );
  }
}

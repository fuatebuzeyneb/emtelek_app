import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/home/domain/cubit/home_cubit.dart';
import 'package:emtelek/features/search_property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/features/search_property/presentation/widgets/bottom_sheets/property_filter_bottom_sheet.dart';
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
    PropertyCubit propertyCubit = BlocProvider.of<PropertyCubit>(context);
    HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
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
          propertyCubit.changeAdType(5);
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
          propertyCubit.changeAdType(6);
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
          print("Pressed Card 3 - Commercial Property");
        },
      },
    ];
    BlocProvider.of<SettingsCubit>(context).openBox();
    homeCubit.startTimer();
    homeCubit.getHomeData();
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
                  SizedBox(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        key: ValueKey<int>(homeCubit.currentIndex),
                        children: [
                          SizedBox(
                            height: context.height * 0.06,
                            width: context.width * 0.8,
                            child: TextFieldWidget(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset(
                                  homeCubit.currentIconAndText['image'],
                                  color: Colors.grey,
                                  height: 5,
                                  width: 5,
                                ),
                              ),
                              hint: homeCubit.currentIconAndText['text'],
                              borderRadius: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                SizedBox(
                                  width: context.width * 1,
                                  height: context.height * 0.22,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeCubit
                                        .homeModel.propertiesRent.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: ProductCardHomeWidget(
                                          adsModel: homeCubit
                                              .homeModel.propertiesRent[index],
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
                                SizedBox(
                                  width: context.width * 1,
                                  height: context.height * 0.22,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeCubit
                                        .homeModel.propertiesSell.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: ProductCardHomeWidget(
                                          adsModel: homeCubit
                                              .homeModel.propertiesSell[index],
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

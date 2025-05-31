import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';

import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/features/add_property_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/features/add_property_listing/presentation/pages/select_ad_category_page.dart';
import 'package:emtelek/features/auth/presentation/pages/login_page.dart';
import 'package:emtelek/features/auth/presentation/pages/signup_page.dart';
import 'package:emtelek/shared/widgets/bottom_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAdBottomSheet extends StatelessWidget {
  const AddAdBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PropertyAddAdCubit addAdsCubit =
        BlocProvider.of<PropertyAddAdCubit>(context);
    final List<Map<String, dynamic>> cardsData = [
      {
        "title": S.of(context).PropertyForSale,
        "image": 'assets/icons/home.png',
        "onTap": () {
          addAdsCubit.changeCategoryForAdType(6);
          pageTransition(context, page: const SelectAdCategoryPage());
        },
      },
      {
        "title": S.of(context).PropertyForRent,
        "image": 'assets/icons/home.png',
        "onTap": () {
          addAdsCubit.changeCategoryForAdType(5);
          pageTransition(context, page: const SelectAdCategoryPage());
        },
      },
      {
        "title": S.of(context).Vehicles,
        "image": 'assets/icons/car.png',
        "onTap": () {},
      },
    ];
    return BottomSheetWidget(
      height: 1,
      widgetBody: Column(
        children: [
          SizedBox(height: context.height * 0.05),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Row(
              children: [
                GestureDetector(
                    child: const Icon(Icons.close),
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
          20.toHeight,
          TextWidget(
            text: S.of(context).WhatWouldYouLikeToAdvertise,
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          // 2.toHeight,
          TextWidget(
            text: S.of(context).ChooseTheAppropriateCategoryForYourAd,
            fontSize: 14,
            color: Colors.black54,
            //fontWeight: FontWeight.bold,
          ),
          20.toHeight,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: context.height * 0.4,
              width: context.width * 1,
              child: GridView.builder(
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
                    paddingVertical: 0,
                    paddingHorizontal: 0,
                    onTap: () {
                      cardData["onTap"]();
                    },
                    color: Colors.white,
                    height: 0,
                    width: 0,
                    borderColor: Colors.black12,
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
                  );
                },
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     ButtonWidget(
          //       onTap: () {
          //         navigateWithCustomTransition(context,
          //             page: const SelectCategoryAddAdsView());
          //       },
          //       color: Colors.white,
          //       height: 0.12,
          //       width: 0.3,
          //       borderColor: Colors.black12,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(
          //             cardsData[0]["icon"],
          //             size: 30,
          //             color: AppColors.kMainColor,
          //           ),
          //           4.toHeight,
          //           TextWidget(
          //             text: cardsData[0]["title"],
          //             fontSize: 14,
          //             color: Colors.black,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ],
          //       ),
          //     ),
          //     ButtonWidget(
          //       onTap: () {
          //         navigateWithCustomTransition(context,
          //             page: const SelectCategoryAddAdsView());
          //       },
          //       color: Colors.white,
          //       height: 0.12,
          //       width: 0.3,
          //       borderColor: Colors.black12,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(
          //             cardsData[1]["icon"],
          //             size: 30,
          //             color: AppColors.kMainColor,
          //           ),
          //           4.toHeight,
          //           TextWidget(
          //             text: cardsData[1]["title"],
          //             fontSize: 14,
          //             color: Colors.black,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ],
          //       ),
          //     ),
          //     ButtonWidget(
          //       onTap: () {},
          //       color: Colors.white,
          //       height: 0.12,
          //       width: 0.3,
          //       borderColor: Colors.black12,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(
          //             cardsData[2]["icon"],
          //             size: 30,
          //             color: AppColors.kMainColor,
          //           ),
          //           4.toHeight,
          //           TextWidget(
          //             text: cardsData[2]["title"],
          //             fontSize: 14,
          //             color: Colors.black,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

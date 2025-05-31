import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/add_property_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/features/add_property_listing/presentation/pages/add_or_edit_ad_details_page.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectAdCategoryPage extends StatelessWidget {
  const SelectAdCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    PropertyAddAdCubit propertyAddAdCubit =
        BlocProvider.of<PropertyAddAdCubit>(context);
    List<int> categories = [];
    if (propertyAddAdCubit.categoryForAdType == 6) {
      categories = [14, 15, 27, 17, 18, 16, 19];
    } else if (propertyAddAdCubit.categoryForAdType == 5) {
      categories = [8, 9, 26, 11, 12, 10, 13, 7];
    }
    final List<Map<String, dynamic>> cardsData = [
      {
        "title": S.of(context).Apartment,
        "image": 'assets/icons/home.png',
        "onTap": () {},
      },
      {
        "title": S.of(context).Shop,
        "image": 'assets/icons/store.png',
        "onTap": () {},
      },
      {
        "title": S.of(context).Office,
        "image": 'assets/icons/office.png',
        "onTap": () {},
      },
      {
        "title": S.of(context).Land,
        "image": 'assets/icons/land.png',
        "onTap": () {
          print("Pressed Card 3 - Commercial Property");
        },
      },
      {
        "title": S.of(context).Villa,
        "image": 'assets/icons/house.png',
        "onTap": () {
          print("Pressed Card 3 - Commercial Property");
        },
      },
      {
        "title": S.of(context).Building,
        "image": 'assets/icons/building.png',
        "onTap": () {
          print("Pressed Card 3 - Commercial Property");
        },
      },
      {
        "title": S.of(context).Factory,
        "image": 'assets/icons/factory.png',
        "onTap": () {
          print("Pressed Card 3 - Commercial Property");
        },
      },
    ];
    if (propertyAddAdCubit.categoryForAdType != 6) {
      cardsData.add({
        "title": S.of(context).Room,
        "image": 'assets/icons/room.png',
        "onTap": () {
          print("Pressed Card 3 - Commercial Property");
        },
      });
    }
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 2,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: const Icon(Icons.arrow_back_ios),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextWidget(
                text: S.of(context).AddYourAd,
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.appBarBackground,
      ),
      body: Column(
        children: [
          SizedBox(height: context.height * 0.03),
          TextWidget(
            text: S.of(context).ChooseTheRightCategory,
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          16.toHeight,
          // 2.toHeight,
          // const TextWidget(
          //   text: 'اختر الفئة المناسبة لاعلانك',
          //   fontSize: 14,
          //   color: Colors.black54,
          //   //fontWeight: FontWeight.bold,
          // ),
          // 20.toHeight,
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
                  childAspectRatio: 1.2, //
                ),
                itemCount: cardsData.length,
                itemBuilder: (context, index) {
                  final cardData = cardsData[index];
                  return ButtonWidget(
                    paddingVertical: 0,
                    paddingHorizontal: 0,
                    onTap: () {
                      propertyAddAdCubit
                          .changeCategoryForAdType(categories[index]);
                      //DetailsForAddAdsView
                      pageTransition(context,
                          page: const AddOrEditAdDetailsPage(
                            itIsEdit: false,
                          ));
                      print(
                          "Pressed Card 3 - Commercial Property ${propertyAddAdCubit.categoryForAdType}");
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
                          width: 32,
                          height: 32,
                          color: AppColors.primary,
                        ),
                        8.toHeight,
                        TextWidget(
                          text: cardData["title"],
                          fontSize: 16,
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
        ],
      ),
    );
  }
}

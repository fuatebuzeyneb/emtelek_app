import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/search_property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/core/utils/page_transitions.dart';
import 'package:emtelek/shared/models/city-model/city_model.dart';
import 'package:emtelek/shared/models/district-model/district_model.dart';
import 'package:emtelek/core/constants/app_colors.dart';

import 'package:emtelek/shared/widgets/tab_style_button_widget.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectLocationFilterView extends StatelessWidget {
  const SelectLocationFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    PropertyCubit propertyCubit = BlocProvider.of<PropertyCubit>(context);
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    return BlocConsumer<PropertyCubit, PropertyState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: context.height * 0.065),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          child: const Icon(Icons.close),
                          onTap: () {
                            // for (var item
                            //     in propertyCubit.selectCitiesAndDistricts) {
                            //   print(
                            //       'CitiName is ${item.cityName ?? item.districtName}');
                            // }
                            Navigator.pop(context);
                          }),
                      const TextWidget(
                        text: 'Logo',
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      const TextWidget(
                        text: 'Logo',
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(children: [
                      20.toHeight,
                      Row(
                        children: [
                          const TextWidget(
                            text: 'الموقع',
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          6.toWidth,
                          const TextWidget(
                            text: '(اختر المدن او المناطق)',
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      10.toHeight,
                      TextFieldWidget(
                        hint: 'دمشق، المهاجرين،',
                        prefixIcon: const Icon(Icons.location_on,
                            color: Colors.black87),
                        onChanged: (value) {
                          // propertyCubit.filterCities(
                          //   value: value,
                          //   globalCities: settingsCubit.globalCities,
                          // );
                          // propertyCubit.filterDistricts(
                          //   value: value,
                          //   globalDistricts: settingsCubit.globalDistricts,
                          // );

                          propertyCubit.filterCitiesAndDistricts(
                              value: value,
                              globalCities: settingsCubit.globalCities,
                              globalDistricts: settingsCubit.globalDistricts);

                          print('value is $value');
                        },
                      ),
                      propertyCubit.selectCitiesAndDistricts.isNotEmpty
                          ? 10.toHeight
                          : 0.toHeight,
                      propertyCubit.selectCitiesAndDistricts.isNotEmpty
                          ? SizedBox(
                              height: context.height * 0.05,
                              width: context.width * 1,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: propertyCubit
                                    .selectCitiesAndDistricts.length,
                                itemBuilder: (context, index) {
                                  // عكس القائمة باستخدام reversed
                                  var reversedList = propertyCubit
                                      .selectCitiesAndDistricts.reversed
                                      .toList();
                                  var item = reversedList[index];

                                  String displayName = '';

                                  // If it's a city, show the city name, otherwise show the district name
                                  if (item is CityModel) {
                                    displayName = item.cityName;
                                  } else if (item is DistrictModel) {
                                    displayName = item.districtName;
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: ButtonWidget(
                                      paddingHorizontal: 16,
                                      paddingVertical: 8,
                                      height: 0,
                                      width: 0,
                                      color: Colors.black,
                                      onTap: () {
                                        int originalIndex = propertyCubit
                                                .selectCitiesAndDistricts
                                                .length -
                                            1 -
                                            index;
                                        propertyCubit.unSelectCityAndDistricts(
                                            index: originalIndex);
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(Icons.close,
                                              color: Colors.white, size: 16),
                                          6.toWidth,
                                          TextWidget(
                                            text: displayName,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ))
                          : const SizedBox(),
                      10.toHeight,
                      SizedBox(
                        height: context.height * 0.62,
                        width: context.width * 1,
                        child: (propertyCubit.filteredCities.isNotEmpty ||
                                propertyCubit.filteredDistricts.isNotEmpty)
                            ? ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: propertyCubit.filteredCities.length +
                                    propertyCubit.filteredDistricts.length,
                                itemBuilder: (context, index) {
                                  dynamic item;
                                  String displayName = '';

                                  // Determine if the item is a city or a district
                                  if (index <
                                      propertyCubit.filteredCities.length) {
                                    item = propertyCubit.filteredCities[index];
                                    displayName = item.cityName;
                                  } else {
                                    item = propertyCubit.filteredDistricts[
                                        index -
                                            propertyCubit
                                                .filteredCities.length];
                                    displayName = item.districtName;
                                  }

                                  return ListTile(
                                    title: Column(
                                      children: [
                                        Row(
                                          children: [
                                            TextWidget(
                                              text: displayName,
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      propertyCubit.selectCityAndDistricts(
                                          value: item);
                                    },
                                  );
                                },
                              )
                            : const Center(
                                child: TextWidget(
                                  text: 'لا توجد مدن أو مناطق مطابقة',
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      20.toHeight,
                      ButtonWidget(
                        onTap: () {},
                        color: Colors.black,
                        colorText: Colors.white,
                        text: 'متابعة',
                        width: 1,
                        fontSize: 16,
                        height: 0.06,
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

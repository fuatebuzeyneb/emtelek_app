import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/features/add_property_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/shared/cubits/cubit/add_ad_global_cubit.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitySelectionAlertDialog extends StatelessWidget {
  const CitySelectionAlertDialog({
    super.key,
  });
  // final int forWitchType; //if 1 for property if 2 for car
  //   final void Function(int?) onTap;
  @override
  Widget build(BuildContext context) {
    final settingsCubit = BlocProvider.of<SettingsCubit>(context);
    final addAdGlobalCubit = BlocProvider.of<AddAdGlobalCubit>(context);
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(),
      backgroundColor: Colors.white,
      content: SizedBox(
        height: context.height * 0.75,
        width: context.width * 1,
        child: ListView.builder(
          itemCount: settingsCubit.globalCities.length,
          itemBuilder: (BuildContext context, int index) {
            return ButtonWidget(
              paddingHorizontal: 0,
              paddingVertical: 0,
              width: 0,
              height: 0,
              // text: (index + 1).toString(),
              // colorText: Colors.black38,
              onTap: () {
                addAdGlobalCubit.changeCityId(
                    id: settingsCubit.globalCities[index].cityId);
                // propertyAddAdCubit.setPropertyField('adModelDistrictId',
                //     settingsCubit.globalCities[index].cityId);
                Navigator.pop(context);
                settingsCubit.filteredDistricts = settingsCubit.globalDistricts
                    .where((district) =>
                        district.cityId == addAdGlobalCubit.cityId)
                    .toList();
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 0,
                            width: 0,
                            child: Radio(
                              value: settingsCubit.globalCities[index].cityId,
                              groupValue: addAdGlobalCubit.cityId,
                              onChanged: (value) {
                                addAdGlobalCubit.changeCityId(id: value!);
                                // propertyAddAdCubit.setPropertyField(
                                //     'adModelDistrictId',
                                //     settingsCubit.globalCities[index].cityId);
                                Navigator.pop(context);
                                settingsCubit.filteredDistricts = settingsCubit
                                    .globalDistricts
                                    .where((district) =>
                                        district.cityId ==
                                        addAdGlobalCubit.cityId)
                                    .toList();
                              },
                            ),
                          ),
                          TextWidget(
                            text: settingsCubit.globalCities[index].cityName,
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 0,
                    // width: 0,
                    child: const Divider(
                      color: Colors.black38,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

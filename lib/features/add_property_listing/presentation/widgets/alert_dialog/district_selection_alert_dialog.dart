import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/features/add_property_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/shared/cubits/cubit/add_ad_global_cubit.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistrictSelectionAlertDialog extends StatelessWidget {
  const DistrictSelectionAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);
    final addAdGlobalCubit = context.read<AddAdGlobalCubit>();
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(),
      backgroundColor: Colors.white,
      content: SizedBox(
        height: context.height * 0.091 * settingsCubit.filteredDistricts.length,
        width: context.width * 1,
        child: ListView.builder(
          itemCount: settingsCubit.filteredDistricts.length,
          itemBuilder: (BuildContext context, int index) {
            return ButtonWidget(
              paddingHorizontal: 0,
              paddingVertical: 0,
              width: 0,
              height: 0,
              // text: (index + 1).toString(),
              // colorText: Colors.black38,
              onTap: () {
                addAdGlobalCubit.changeDistrictId(
                  id: settingsCubit.filteredDistricts[index].districtId,
                );

                Navigator.pop(context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                              value: settingsCubit
                                  .filteredDistricts[index].districtId,
                              groupValue: addAdGlobalCubit.districtId,
                              onChanged: (value) {
                                addAdGlobalCubit.changeDistrictId(
                                  id: settingsCubit
                                      .filteredDistricts[index].districtId,
                                );

                                Navigator.pop(context);
                              },
                            ),
                          ),
                          TextWidget(
                            text: settingsCubit
                                .filteredDistricts[index].districtName,
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

import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/search_property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortAlertDialogWidget extends StatelessWidget {
  const SortAlertDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    final propertyCubit = context.read<PropertyCubit>();

    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            text: 'ترتيب',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: StatefulBuilder(
        builder: (context, setState) {
          List<Map<String, dynamic>> options = [
            {
              'label': S.current.DateNewToOld,
              'value': 'PublishDate DESC',
            },
            {
              'label': S.current.DateOldToNew,
              'value': 'PublishDate ASC',
            },
            {
              'label': S.current.PriceHighToLow,
              'value': 'Price DESC',
            },
            {
              'label': S.current.PriceLowToHigh,
              'value': 'Price ASC',
            },
          ];

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...options.map((option) {
                return ButtonWidget(
                  height: 0,
                  width: 0,
                  onTap: () {
                    settingsCubit.selectSortByFunction(value: option['value']);

                    setState(() {});
                    propertyCubit.applyFilter(
                      listCityIds: settingsCubit.selectedCityIds,
                      listDistrictIds: settingsCubit.selectedDistrictIds,
                      minPrice: settingsCubit.minPrice?.toInt(),
                      maxPrice: settingsCubit.maxPrice?.toInt(),
                      sortBy: settingsCubit.sortBy,
                    );
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: option['label'],
                        fontSize: 14,
                      ),
                      Radio<String>(
                        activeColor: AppColors.primary,
                        value: option['value'],
                        groupValue: settingsCubit.sortBy,
                        onChanged: (value) {
                          settingsCubit.selectSortByFunction(value: value!);
                          setState(() {});

                          propertyCubit.applyFilter(
                            listCityIds: settingsCubit.selectedCityIds,
                            listDistrictIds: settingsCubit.selectedDistrictIds,
                            minPrice: settingsCubit.minPrice?.toInt(),
                            maxPrice: settingsCubit.maxPrice?.toInt(),
                            sortBy: settingsCubit.sortBy,
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/features/add_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/widgets/button_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencySelectionAlertDialog extends StatelessWidget {
  const CurrencySelectionAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final propertyAddAdCubit = context.read<PropertyAddAdCubit>();
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            text: 'اختر العملة',
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
              'label': S.current.SyrianPound,
              'value': 'SYP',
            },
            {
              'label': S.current.USD,
              'value': 'USD',
            },
            {
              'label': S.current.TurkishLira,
              'value': 'TRY',
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
                    propertyAddAdCubit.setPropertyField(
                        'adModelCurrency', option['value']);
                    print(option['value']);

                    setState(() {});

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
                        groupValue: propertyAddAdCubit.adModel.currency,
                        onChanged: (value) {
                          propertyAddAdCubit.setPropertyField(
                              'adModelCurrency', option['value']);
                          print(option['value']);
                          setState(() {});

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

import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/widgets/left_hint_text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class PriceRangeWidget extends StatefulWidget {
  const PriceRangeWidget({super.key});

  @override
  _PriceRangeWidgetState createState() => _PriceRangeWidgetState();
}

class _PriceRangeWidgetState extends State<PriceRangeWidget> {
  late TextEditingController minPriceController;
  late TextEditingController maxPriceController;

  @override
  void initState() {
    super.initState();
    final settingsCubit = context.read<SettingsCubit>();

    // ✅ ضبط القيم الأولية بناءً على القيم المخزنة (أو تركها فارغة إذا كانت `null`)
    minPriceController = TextEditingController(
        text: settingsCubit.minPrice?.toStringAsFixed(0) ?? '');
    maxPriceController = TextEditingController(
        text: settingsCubit.maxPrice?.toStringAsFixed(0) ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        final settingsCubit = context.read<SettingsCubit>();

        // ✅ تحديث القيم فقط عند تغييرها
        minPriceController.text =
            settingsCubit.minPrice?.toStringAsFixed(0) ?? '';
        maxPriceController.text =
            settingsCubit.maxPrice?.toStringAsFixed(0) ?? '';
      },
      builder: (context, state) {
        final settingsCubit = context.watch<SettingsCubit>();

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: context.height * 0.06,
                  width: context.width * 0.42,
                  child: LeftHintTextFieldWidget(
                    textEditingController: minPriceController,
                    onChanged: (value) {
                      double? parsedValue = double.tryParse(value);
                      settingsCubit.updateMinPrice(parsedValue);
                    },
                    hint: 'ل.س',
                    keyboardType: TextInputType.number,
                  ),
                ),
                TextWidget(
                  text: S.of(context).To,
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: context.height * 0.06,
                  width: context.width * 0.42,
                  child: LeftHintTextFieldWidget(
                    textEditingController: maxPriceController,
                    onChanged: (value) {
                      double? parsedValue = double.tryParse(value);
                      settingsCubit.updateMaxPrice(parsedValue);
                    },
                    hint: 'ل.س',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            10.toHeight,
            FlutterSlider(
              values: [
                settingsCubit.minPrice ??
                    0.0, // إذا كانت `null` نستخدم 0 فقط للسلايدر
                settingsCubit.maxPrice ??
                    900.0 // إذا كانت `null` نستخدم 1000 فقط للسلايدر
              ],
              max: 900,
              min: 0,
              rangeSlider: true,
              handlerHeight: 20,
              handlerWidth: 20,
              trackBar: FlutterSliderTrackBar(
                activeTrackBarHeight: 5,
                activeTrackBar: const BoxDecoration(color: Colors.black),
                inactiveTrackBar: BoxDecoration(color: Colors.grey[300]),
              ),
              handler: FlutterSliderHandler(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
              rightHandler: FlutterSliderHandler(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
              onDragging: (handlerIndex, lowerValue, upperValue) {
                settingsCubit.updatePriceRange(lowerValue, upperValue);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }
}

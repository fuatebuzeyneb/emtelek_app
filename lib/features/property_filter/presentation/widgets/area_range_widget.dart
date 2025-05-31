import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/features/property/domain/property_cubit/property_cubit.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/widgets/left_hint_text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class AreaRangeWidget extends StatefulWidget {
  const AreaRangeWidget({super.key});

  @override
  _AreaRangeWidgetState createState() => _AreaRangeWidgetState();
}

class _AreaRangeWidgetState extends State<AreaRangeWidget> {
  late TextEditingController minAreaController;
  late TextEditingController maxAreaController;

  @override
  void initState() {
    super.initState();
    final propertyCubit = context.read<PropertyCubit>();

    // ✅ ضبط القيم الأولية بناءً على القيم المخزنة (أو تركها فارغة إذا كانت `null`)
    minAreaController = TextEditingController(
        text: propertyCubit.minArea?.toStringAsFixed(0) ?? '');
    maxAreaController = TextEditingController(
        text: propertyCubit.maxArea?.toStringAsFixed(0) ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertyCubit, PropertyState>(
      listener: (context, state) {
        final propertyCubit = context.read<PropertyCubit>();

        // ✅ تحديث القيم فقط عند تغييرها
        minAreaController.text =
            propertyCubit.minArea?.toStringAsFixed(0) ?? '';
        maxAreaController.text =
            propertyCubit.maxArea?.toStringAsFixed(0) ?? '';
      },
      builder: (context, state) {
        final propertyCubit = context.watch<PropertyCubit>();

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: context.height * 0.06,
                  width: context.width * 0.42,
                  child: LeftHintTextFieldWidget(
                    textEditingController: minAreaController,
                    onChanged: (value) {
                      double? parsedValue = double.tryParse(value);
                      propertyCubit.updateMinArea(parsedValue);
                    },
                    hint: 'م²',
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
                    textEditingController: maxAreaController,
                    onChanged: (value) {
                      double? parsedValue = double.tryParse(value);
                      propertyCubit.updateMaxArea(parsedValue);
                    },
                    hint: 'م²',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            10.toHeight,
            FlutterSlider(
              values: [
                propertyCubit.minArea ??
                    0.0, // إذا كانت `null` نستخدم 0 فقط للسلايدر
                propertyCubit.maxArea ??
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
                propertyCubit.updateAreaRange(lowerValue, upperValue);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    minAreaController.dispose();
    maxAreaController.dispose();
    super.dispose();
  }
}

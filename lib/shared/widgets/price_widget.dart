import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/extensions/sized_box_extensions.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/widgets/left_hint_text_field_widget.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: context.height * 0.06,
              width: context.width * 0.42,
              child: const LeftHintTextFieldWidget(
                  initialValue: '0.0',
                  hint: 'ل.س',
                  keyboardType: TextInputType.number),
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
              child: const LeftHintTextFieldWidget(
                  initialValue: '0.0',
                  hint: 'ل.س',
                  keyboardType: TextInputType.number),
            ),
          ],
        ),
        10.toHeight,
        FlutterSlider(
          values: const [0, 1000],
          max: 1000,
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
          onDragging: (handlerIndex, lowerValue, upperValue) {},
        ),
      ],
    );
  }
}

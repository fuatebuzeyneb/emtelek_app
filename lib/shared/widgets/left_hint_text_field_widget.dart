import 'package:emtelek/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LeftHintTextFieldWidget extends StatelessWidget {
  const LeftHintTextFieldWidget({
    super.key,
    this.hint,
    this.onChanged,
    this.keyboardType,
    this.initialValue,
    this.textEditingController,
  });

  final String? hint;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? initialValue;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
          controller: textEditingController,
          initialValue: initialValue,
          keyboardType: keyboardType,
          onChanged: onChanged,
          cursorColor: AppColors.primary,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
            // إزالة النص المساعد من هنا لضمان ظهوره بشكل منفصل
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
          ),
        ),
        // الهينت (النص المساعد) على اليسار
        if (hint != null)
          Positioned(
            left: 10,
            child: Text(
              hint!,
              style: const TextStyle(
                color: Colors.grey,
                fontFamily: 'Tajawal',
              ),
            ),
          ),
      ],
    );
  }
}

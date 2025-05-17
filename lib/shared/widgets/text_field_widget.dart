import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.hint,
    this.onChanged,
    this.keyboardType,
    this.initialValue,
    this.prefixIcon,
    this.borderRadius = 6,
    this.paddingVertical = 14.0,
    this.maxLines = 1,
    this.suffixWidget,
    this.label,
    this.controller,
  });

  final String? hint;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? initialValue;
  final Widget? prefixIcon;
  final double? borderRadius;
  final double? paddingVertical;
  final int? maxLines;
  final Widget? suffixWidget;
  final Widget? label;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      initialValue: initialValue,
      keyboardType: keyboardType,
      onChanged: onChanged,
      cursorColor: AppColors.primary,
      textAlign: getIt<CacheHelper>().getDataString(key: 'Lang') == 'ar'
          ? TextAlign.right
          : TextAlign.left,
      decoration: InputDecoration(
        suffixIcon: suffixWidget,
        prefixIcon: prefixIcon,
        contentPadding:
            EdgeInsets.symmetric(vertical: paddingVertical!, horizontal: 12.0),
        hintText: hint,
        label: label,
        hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Tajawal'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: const BorderSide(color: Colors.black, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius!),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius!),
          ),
        ),
      ),
    );
  }
}

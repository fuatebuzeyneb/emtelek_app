import 'package:flutter/material.dart';

extension SizedBoxExtension on int {
  Widget get toHeight => SizedBox(height: toDouble());
  Widget get toWidth => SizedBox(width: toDouble());
}

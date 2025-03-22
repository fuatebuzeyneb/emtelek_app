// lib/core/extensions/alignment_extension.dart
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:flutter/material.dart';
import 'package:emtelek/shared/services/service_locator.dart';

extension AlignmentExtension on BuildContext {
  Alignment get textAlignment {
    return getIt<CacheHelper>().getDataString(key: 'Lang') == 'ar'
        ? Alignment.centerRight
        : Alignment.centerLeft;
  }
}

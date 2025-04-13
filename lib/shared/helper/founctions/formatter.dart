import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

class Formatter {
  static String formatNumber(double number) {
    String formattedNumber = number.toStringAsFixed(2);

    // Split integer and decimal parts
    List<String> parts = formattedNumber.split('.');
    String integerPart = parts[0];
    String decimalPart = parts[1];

    // Add thousand separators to integer part
    String formattedIntegerPart = integerPart.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match m) => "${m[1]},",
    );

    return "$formattedIntegerPart.$decimalPart";
  }

  static String convertCurrencySymbol(String input) {
    if (getIt<CacheHelper>().getDataString(key: 'Lang') == 'ar') {
      switch (input.toUpperCase()) {
        case 'SYP':
          return 'ل.س';
        case 'TRY':
          return 'ل.ت';
        case 'USD':
          return 'دولار';
        default:
      }
    }
    return input;
  }
}

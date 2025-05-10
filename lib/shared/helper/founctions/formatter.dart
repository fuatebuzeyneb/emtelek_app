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

  static String convertArabicNumbersToEnglish(String input) {
    const arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const englishNumbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    for (int i = 0; i < arabicNumbers.length; i++) {
      input = input.replaceAll(arabicNumbers[i], englishNumbers[i]);
    }

    return input;
  }

  static DateTime? parseConstructionDate(dynamic value) {
    try {
      String str = value?.toString().trim() ?? '';
      str = convertArabicNumbersToEnglish(str);
      if (str.isEmpty) return null;

      if (str.length == 4 && int.tryParse(str) != null) {
        // إذا كانت فقط سنة مثل 2009
        return DateTime(int.parse(str));
      }

      return DateTime.parse(str); // تاريخ كامل
    } catch (e) {
      print('⚠️ خطأ في التحويل إلى تاريخ: $e');
      return null;
    }
  }
}

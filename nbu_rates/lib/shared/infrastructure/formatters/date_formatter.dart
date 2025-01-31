import 'package:easy_localization/easy_localization.dart';

class DateFormatter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyyMMdd').format(dateTime);
  }

  static String shwoFormat(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}
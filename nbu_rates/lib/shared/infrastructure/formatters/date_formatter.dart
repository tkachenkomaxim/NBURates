import 'package:easy_localization/easy_localization.dart';

class DateFormatter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyyMMdd').format(dateTime);
  }
}
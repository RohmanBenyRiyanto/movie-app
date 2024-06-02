import 'package:intl/intl.dart';

class DateHandler {
  DateHandler._();

  static DateHandler? _instance;
  static DateHandler get instance => _instance ??= DateHandler._();

  //* Convert to '05 Sep 2023'
  String ddMMMYYYY(String? date) {
    if (date == null || date.isEmpty) return "-";
    final result = DateTime.parse(date).toLocal();
    return DateFormat("dd MMM yyyy").format(result);
  }
}

library string_extension;

import 'dart:ui';

import '../res/res.dart';

extension StringExtension on String {
  /// Convert string to boolean, "1" -> true, "0" -> false
  bool stringToBool() => isNotEmpty && this == "1";

  /// Convert string to enum
  Locale strToLocale() {
    if (this == Constant.app.setLocalID) {
      return Constant.app.localeID;
    } else {
      return Constant.app.localeEN;
    }
  }
}

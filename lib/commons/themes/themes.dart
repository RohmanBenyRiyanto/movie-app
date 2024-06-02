export 'app_dimens.dart';
export 'app_text_style.dart';
export 'app_theme.dart';

import 'package:flutter/material.dart';

import '../../core/routes/routes.dart';

class ThemeHelper {
  static BuildContext? get _context => navKey.currentContext;

  static ColorScheme get getColorScheme {
    return Theme.of(_context!).colorScheme;
  }

  static TextTheme get getTextTheme {
    return Theme.of(_context!).textTheme;
  }
}

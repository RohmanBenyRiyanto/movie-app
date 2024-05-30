import 'dart:ui';

enum LanguageType {
  english,
  indonesia,
}

extension LanguageTypeExtension on LanguageType {
  String langCode() {
    switch (this) {
      case LanguageType.english:
        return 'en';
      case LanguageType.indonesia:
        return 'id';
    }
  }

  String langCountryCode() {
    switch (this) {
      case LanguageType.english:
        return 'US';
      case LanguageType.indonesia:
        return 'ID';
    }
  }

  Locale locale() {
    switch (this) {
      case LanguageType.english:
        return const Locale('en', 'US');
      case LanguageType.indonesia:
        return const Locale('id', 'ID');
    }
  }

  String get completeLangCode => '$langCode-$langCountryCode';
}

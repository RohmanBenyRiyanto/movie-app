part of '../constant.dart';

class AppConstans {
  const AppConstans();

  String get setLocalEN => 'en';
  String get setLocalID => 'id';

  Locale get localeEN => const Locale('en', 'US');
  Locale get localeID => const Locale('id', 'ID');

  List<Locale> get supportedLocales => <Locale>[localeEN, localeID];
}

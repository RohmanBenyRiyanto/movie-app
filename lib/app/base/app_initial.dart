import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:movie/app/utils/utils.dart';

import '../../core/injections/injection.dart';
import '../../core/service/local_storage/local_storage.dart';

abstract class AppInitial {
  AppInitial() {
    _init();
  }

  FutureOr<StatelessWidget> onCreate();

  Future<void> _init() async {
    await runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await _configureInjection();
        await _configureSystemChrome();
        await _initializeLocalStorageAndLocalization();
        _runApp(await onCreate());
      },
      (error, stack) {
        Print.error(
          "Something went wrong",
          error: error,
          stackTrace: stack,
        );
      },
    );
  }

  Future<void> _configureInjection() async => await configureInjection();

  Future<void> _configureSystemChrome() async =>
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]);

  Future<void> _initializeLocalStorageAndLocalization() async {
    final localStorage = locator<LocalStorage>();
    await localStorage.initialize();
    Intl.defaultLocale =
        await localStorage.getLanguage().then((value) => value.toString());
    await initializeDateFormatting();
  }

  void _runApp(StatelessWidget app) {
    runApp(app);
  }
}

import 'dart:io';
import 'dart:ui';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../app/extensions/extensions.dart';
import '../../../app/res/res.dart';

@lazySingleton
class LocalStorage {
  final FlutterSecureStorage _storage;

  LocalStorage(this._storage);

  /// Addressed the issue of local storage not being deleted when reinstalling the app (the issue was on iOS devices)<br/>
  Future<void> initialize() async {
    try {
      final isFirstInstall =
          !(await _storage.read(key: Constant.localKey.isHashRun))
              .toString()
              .stringToBool();

      if (isFirstInstall) {
        // Delete all data when the app is first installed
        await _storage.deleteAll();
        await _storage.write(
          key: Constant.localKey.isHashRun,
          value: true.boolToString,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setLanguage(String language) async {
    await _storage.write(key: Constant.localKey.language, value: language);
  }

  Future<Locale> getLanguage() async {
    final language = await _storage.read(key: Constant.localKey.language);

    if (language != null) {
      return language.strToLocale();
    } else {
      if (Platform.localeName.split('_')[0] != Constant.app.setLocalID) {
        return Constant.app.localeEN;
      } else {
        return Constant.app.localeID;
      }
    }
  }
}

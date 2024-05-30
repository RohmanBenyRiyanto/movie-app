import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/app/res/constant/constant.dart';

import '../../../../core/injections/injection.dart';
import '../../../../core/service/local_storage/local_storage.dart';

part 'locale_cubit.freezed.dart';
part 'locale_state.dart';

@injectable
class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState.selected(_checkDeviceLocale()));

  final _localStorage = locator<LocalStorage>();

  //* Check Device Locale and emit selected locale
  static Locale _checkDeviceLocale() {
    if (Platform.localeName.split('_')[0] != Constant.app.setLocalID) {
      return Constant.app.localeEN;
    } else {
      return Constant.app.localeID;
    }
  }

  //* On Check Locale from App Local Storage
  Future<void> init() async {
    emit(LocaleState.selected(await _localStorage.getLanguage()));
  }
}

part of 'locale_cubit.dart';

@freezed
class LocaleState with _$LocaleState {
  const factory LocaleState.selected(Locale locale) = SelectedLocale;
}

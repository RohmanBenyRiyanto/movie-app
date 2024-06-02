part of 'select_category_cubit.dart';

@freezed
class SelectCategoryState with _$SelectCategoryState {
  const factory SelectCategoryState.selected({
    @Default(null) GenreDataEntity? selected,
  }) = _Success;
}

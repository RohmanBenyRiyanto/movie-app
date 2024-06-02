part of 'get_by_category_cubit.dart';

@freezed
class GetByCategoryState with _$GetByCategoryState {
  const factory GetByCategoryState.initial() = _Initial;
  const factory GetByCategoryState.loading() = _Loading;
  const factory GetByCategoryState.success({
    @Default([]) List<ResultEntity>? data,
    @Default(false) bool isLoadMore,
    @Default(false) bool hasNextPage,
  }) = _Success;
  const factory GetByCategoryState.failure(Failure failure) = _Failure;
}

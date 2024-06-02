part of 'search_cubit.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.success({
    @Default([]) List<ResultEntity>? data,
    @Default(false) bool isLoadMore,
    @Default(false) bool hasNextPage,
  }) = _Success;
  const factory SearchState.failure(Failure failure) = _Failure;
}

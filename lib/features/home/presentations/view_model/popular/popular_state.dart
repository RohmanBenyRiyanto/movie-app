part of 'popular_cubit.dart';

@freezed
class PopularState with _$PopularState {
  const factory PopularState.initial() = _Initial;
  const factory PopularState.loading() = _Loading;
  const factory PopularState.failure(Failure failure) = _Failed;
  const factory PopularState.success({required MovieListEntity movies}) =
      _Loaded;
}

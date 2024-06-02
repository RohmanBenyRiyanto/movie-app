part of 'get_now_playing_cubit.dart';

@freezed
class GetNowPlayingState with _$GetNowPlayingState {
  const factory GetNowPlayingState.initial() = _Initial;
  const factory GetNowPlayingState.loading() = _Loading;
  const factory GetNowPlayingState.success({
    @Default([]) List<ResultEntity>? data,
    @Default(false) bool isLoadMore,
    @Default(false) bool hasNextPage,
  }) = _Success;
  const factory GetNowPlayingState.failure(Failure failure) = _Failure;
}

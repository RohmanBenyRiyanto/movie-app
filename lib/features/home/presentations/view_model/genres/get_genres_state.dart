part of 'get_genres_cubit.dart';

@freezed
class GetGenresState with _$GetGenresState {
  const factory GetGenresState.initial() = _Initial;
  const factory GetGenresState.loading() = _Loading;
  const factory GetGenresState.failure(Failure failure) = _Failed;
  const factory GetGenresState.success({required GenreEntity genres}) = _Loaded;
}

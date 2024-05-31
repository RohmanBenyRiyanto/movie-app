import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/movie_list_entity.dart';

part 'movie_list_model.freezed.dart';
part 'movie_list_model.g.dart';

@freezed
class NowPlayingModel with _$NowPlayingModel {
  @JsonSerializable(explicitToJson: true)
  @Implements<MovieListEntity>()
  const factory NowPlayingModel({
    int? page,
    List<ResultModel>? results,
    int? totalPages,
    int? totalResults,
  }) = _NowPlayingModel;

  factory NowPlayingModel.fromJson(Map<String, dynamic> json) =>
      _$NowPlayingModelFromJson(json);
}

@freezed
class ResultModel with _$ResultModel {
  @JsonSerializable(explicitToJson: true)
  @Implements<Result>()
  const factory ResultModel({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    DateTime? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) = _Result;

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);
}

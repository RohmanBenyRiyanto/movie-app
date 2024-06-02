import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/search_movie_entity.dart';

part 'search_movie_model.freezed.dart';
part 'search_movie_model.g.dart';

@freezed
class SearchMovieModel extends SearchMovieEntity with _$SearchMovieModel {
  @JsonSerializable(
    explicitToJson: true,
    fieldRename: FieldRename.snake,
  )
  const factory SearchMovieModel({
    int? page,
    List<ResultModel>? results,
    int? totalPages,
    int? totalResults,
  }) = _SearchMovieModel;

  factory SearchMovieModel.fromJson(Map<String, dynamic> json) =>
      _$SearchMovieModelFromJson(json);
}

@freezed
class ResultModel extends ResultEntity with _$ResultModel {
  @JsonSerializable(
    explicitToJson: true,
    fieldRename: FieldRename.snake,
  )
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
    String? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) = _ResultModel;

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);
}

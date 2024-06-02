import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/service/network/network.dart';
import '../../domain/entity/movie_list_entity.dart';

part 'movie_list_model.freezed.dart';
part 'movie_list_model.g.dart';

@freezed
class MovieListModel extends MovieListEntity with _$MovieListModel {
  @JsonSerializable(
    explicitToJson: true,
    fieldRename: FieldRename.snake,
  )
  const factory MovieListModel({
    DatesModel? dates,
    int? page,
    List<ResultModel>? results,
    int? totalPages,
    int? totalResults,
  }) = _MovieListModel;

  factory MovieListModel.fromJson(Map<String, dynamic> json) =>
      _$MovieListModelFromJson(json);
}

@freezed
class DatesModel extends BaseDates with _$DatesModel {
  @JsonSerializable(
    explicitToJson: true,
    fieldRename: FieldRename.snake,
  )
  const factory DatesModel({
    DateTime? maximum,
    DateTime? minimum,
  }) = _Dates;

  factory DatesModel.fromJson(Map<String, dynamic> json) =>
      _$DatesModelFromJson(json);
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
  }) = _Result;

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);
}

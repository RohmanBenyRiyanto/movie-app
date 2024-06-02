import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/genres_entity.dart';

part 'genres_model.freezed.dart';
part 'genres_model.g.dart';

@freezed
class GenreModel extends GenreEntity with _$GenreModel {
  @JsonSerializable(
    explicitToJson: true,
    fieldRename: FieldRename.snake,
  )
  const factory GenreModel({
    List<GenreDataModel>? genres,
  }) = _GenreModel;

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);
}

@freezed
class GenreDataModel extends GenreDataEntity with _$GenreDataModel {
  @JsonSerializable(
    explicitToJson: true,
    fieldRename: FieldRename.snake,
  )
  const factory GenreDataModel({
    int? id,
    String? name,
  }) = _GenreDataModel;

  factory GenreDataModel.fromJson(Map<String, dynamic> json) =>
      _$GenreDataModelFromJson(json);
}

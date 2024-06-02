import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_by_category_dto.freezed.dart';
part 'get_by_category_dto.g.dart';

@freezed
class GetByCategoryDto with _$GetByCategoryDto {
  @JsonSerializable(
    explicitToJson: true,
    fieldRename: FieldRename.snake,
  )
  const factory GetByCategoryDto({
    required int idCategory,
    required int page,
  }) = _GetByCategoryDto;

  factory GetByCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$GetByCategoryDtoFromJson(json);
}

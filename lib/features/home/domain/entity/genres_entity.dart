class GenreEntity {
  final List<GenreDataEntity>? genres;

  GenreEntity({
    this.genres,
  });
}

class GenreDataEntity {
  final int? id;
  final String? name;

  GenreDataEntity({
    this.id,
    this.name,
  });
}

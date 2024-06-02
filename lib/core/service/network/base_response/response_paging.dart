abstract class ResponsePaging<T> {
  BaseDates? dates;
  List<T>? results;
  int? page;
  int? totalResults;
  int? totalPages;

  ResponsePaging({
    this.dates,
    this.results,
    this.page,
    this.totalResults,
    this.totalPages,
  });
}

abstract class BaseDates {
  final DateTime? maximum;
  final DateTime? minimum;

  BaseDates({
    this.maximum,
    this.minimum,
  });
}

import '../../../app/config/config.dart';
import '../../../app/res/res.dart';

class ApiEndpoint {
  ApiEndpoint._(this._version);

  final String _version;

  static ApiEndpoint? _v3;
  static ApiEndpoint get _v3Instance => _v3 ??= ApiEndpoint._(Constant.api.v3);

  static String get baseUrl => AppEnvironment.instance.baseUrl;
  static String get baseUrlImg => AppEnvironment.instance.baseUrlImg;
  static String get version => _v3Instance._version;

  static ApiEndpoint get latest => _v3Instance;

  static String _create(String endpoint) => '$baseUrl/$version$endpoint';
  static String _createImage(String size, String path) =>
      "$baseUrlImg/t/p/$size/$path";

  static String imageUrlOriginal(String path) => _createImage("original", path);
  static String imageUrlW92(String path) => _createImage("w92", path);
  static String imageUrlW154(String path) => _createImage("w154", path);
  static String imageUrlW185(String path) => _createImage("w185", path);
  static String imageUrlW300(String path) => _createImage("w300", path);
  static String imageUrlW342(String path) => _createImage("w342", path);
  static String imageUrlW500(String path) => _createImage("w500", path);
  static String imageUrlW780(String path) => _createImage("w780", path);

  // Movie Lists
  String get nowPlaying => _create('/movie/now_playing');
  String get discover => _create('/discover/movie');

  // Genres
  String get genres => _create('/genre/movie/list');

  // Popular Movies
  String popularMovie(String day) => _create('/trending/movie/$day');

  // Search
  String get search => _create('/search/movie');

  // Details
  String detailsMovie(String movieId) => _create('/movie/$movieId');
}

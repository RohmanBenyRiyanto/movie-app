import '../../../app/config/config.dart';
import '../../../app/res/res.dart';

class ApiEndpoint {
  ApiEndpoint._(this._version);

  final String _version;

  static ApiEndpoint? _v3;
  static ApiEndpoint get v3 => _v3 ??= ApiEndpoint._(Constant.api.v3);

  static String get baseUrl => AppEnvironment.instance.baseUrl;
  static String get version => v3._version;
  static String imageUrlOriginal(String path) => "$baseUrl/t/p/original$path";
  static String imageUrlW500(String path) => "$baseUrl/t/p/w500$path";

  static String _create(String endpoint) => '$baseUrl/$version/$endpoint';

  // MOVIE LISTS
  String get nowPlaying => _create('/movie/now_playing');
  String get popular => _create('/movie/popular');
  String get topRated => _create('/movie/top_rated');
  String get upcoming => _create('/movie/upcoming');

  // POPULAR, day = [enum{day, week}]
  static String popularMovie(String day) => _create('/trending/movie/');

  // SEARCH
  String get search => _create('/search/movie');

  // GENRES
  String get genreList => _create('/genre/movie/list');

  // IMAGES
  static String listImage(String movieId) => _create('/movie/$movieId/images');

  // DETAILS
  static String detailsMovie(String movieId) => _create('/movie/$movieId');
}

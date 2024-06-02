import 'package:envied/envied.dart';

part 'env.g.dart';
part 'src/env.dart';

class AppEnvironment {
  AppEnvironment._({
    required String baseURL,
    required String baseUrlImg,
    required String apiKey,
  })  : _baseURL = baseURL,
        _baseUrlImg = baseUrlImg,
        _apiKey = apiKey;

  static AppEnvironment? _instance;
  static AppEnvironment get instance => _instance ??= AppEnvironment._(
        baseURL: DevEnv.baseUrl,
        baseUrlImg: DevEnv.baseUrlImg,
        apiKey: DevEnv.apiKey,
      );

  final String _baseURL;
  final String _baseUrlImg;
  final String _apiKey;

  String get baseUrl => _baseURL;
  String get baseUrlImg => _baseUrlImg;
  String get apiKey => _apiKey;
}

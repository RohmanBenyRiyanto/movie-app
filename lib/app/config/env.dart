import 'package:envied/envied.dart';

part 'src/env.dart';
part 'env.g.dart';

class AppEnvironment {
  AppEnvironment._({
    required String baseURL,
    required String apiKey,
  })  : _baseURL = baseURL,
        _apiKey = apiKey;

  static AppEnvironment? _instance;
  static AppEnvironment get instance => _instance ??= AppEnvironment._(
        baseURL: DevEnv.baseUrl,
        apiKey: DevEnv.apiKey,
      );

  final String _baseURL;
  final String _apiKey;

  String get baseUrl => _baseURL;
  String get apiKey => _apiKey;
}

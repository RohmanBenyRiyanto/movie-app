part of '../env.dart';

@Envied(path: ".env", obfuscate: true)
abstract class DevEnv {
  @EnviedField(varName: 'BASE_URL')
  static String baseUrl = _DevEnv.baseUrl;
  @EnviedField(varName: 'BASE_URL_IMG')
  static String baseUrlImg = _DevEnv.baseUrlImg;
  @EnviedField(varName: 'API_KEY')
  static String apiKey = _DevEnv.apiKey;
}

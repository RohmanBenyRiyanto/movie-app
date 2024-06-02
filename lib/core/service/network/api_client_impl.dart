import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../app/config/env.dart';
import '../../../app/res/constant/constant.dart';
import '../../../app/res/res.dart';

import '../local_storage/local_storage.dart';
import 'network.dart';

@LazySingleton(as: ApiClient)
class ApiClientImpl implements ApiClient {
  ApiClientImpl(this._dio, this._localStorage);

  final Dio _dio;
  final LocalStorage _localStorage;
  String? _token;

  dynamic _returnResponse({required Response response}) {
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw response;
    }
  }

  @override
  Future get({
    required String url,
    Map<String, dynamic>? params,
    bool token = true,
  }) async {
    final Locale language = await _localStorage.getLanguage();
    if (token) {
      _token = AppEnvironment.instance.apiKey;
      _dio.options.headers[Constant.api.headAuthKey] =
          '${Constant.api.headAuthType} $_token';
    }

    final queryParameters = {
      ...params ?? {},
      Constant.api.apiLangKey:
          "${language.languageCode}-${language.countryCode}",
    };

    return _returnResponse(
      response: await _dio.get(
        url,
        queryParameters: queryParameters,
      ),
    );
  }

  @override
  Future post({
    required String url,
    Map<String, dynamic>? body,
    bool token = true,
    Map<String, dynamic>? params,
  }) async {
    final Locale language = await _localStorage.getLanguage();
    if (token) {
      _token = AppEnvironment.instance.apiKey;
      _dio.options.headers[Constant.api.headAuthKey] =
          '${Constant.api.headAuthType} $_token';
    }

    final queryParameters = {
      ...params ?? {},
      Constant.api.apiLangKey:
          "${language.languageCode}-${language.countryCode}",
    };

    return _returnResponse(
      response: await _dio.get(
        url,
        queryParameters: queryParameters,
      ),
    );
  }
}

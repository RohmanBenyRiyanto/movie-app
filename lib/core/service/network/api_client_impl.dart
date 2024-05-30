import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/app/config/env.dart';

import '../../../app/utils/utils.dart';
import '../local_storage/local_storage.dart';
import 'network.dart';

@lazySingleton
class ApiClientImpl {
  ApiClientImpl(this._dio, this._localStorage);

  final Dio _dio;
  final LocalStorage _localStorage;

  Future<dynamic> request(ApiClient request) async {
    Locale language = await _localStorage.getLanguage();

    _dio.interceptors.add(
      ApiInterceptorDefault(
        language: "${language.languageCode}_${language.countryCode}",
        token: request.useInterceptor ? AppEnvironment.instance.apiKey : null,
      ),
    );

    try {
      //! Currently i'm not using connectivity checker
      // if (!ConnectivityChecker.hasConnection) {
      //   throw ConnectionException();
      // }

      final response = await _dio.request(
        request.urlPath,
        queryParameters: request.query,
        data: request.body,
        options: Options(
          method: request.method.name,
          headers: request.headers,
        ),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        //! For Exception, currently i'm only use simple handler
        throw Exception("Something went wrong");
      }
    } on DioException catch (dioError) {
      //! For Exception, currently i'm only use simple exception
      switch (dioError.type) {
        case DioException.connectionTimeout:
          return 'Connection timeout';
        case DioException.sendTimeout:
          return 'Send timeout';
        case DioException.receiveTimeout:
          return 'Receive timeout';
        case DioException.badResponse:
          return 'Bad response';
        case DioException.connectionError:
          return 'Connection error';
        default:
          return 'An unexpected error occurred';
      }
    } catch (e) {
      return 'Oops! An unexpected error occurred. Please try again later.';
    }
  }
}

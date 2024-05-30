import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import '../../app/config/config.dart';
import '../../app/res/res.dart';
import '../../app/utils/utils.dart';

@module
abstract class DioModule {
  @singleton
  Dio get instance {
    Dio dio = Dio(
      BaseOptions(
        followRedirects: false,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true,
        baseUrl: AppEnvironment.instance.baseUrl,
        validateStatus: (status) => status! <= 500,
        receiveTimeout: Constant.api.receiveTimeout,
        connectTimeout: Constant.api.connectionTimeout,
        headers: Constant.api.headers,
      ),
    );
    if (kDebugMode) dio.interceptors.add(ApiInterceptorLogging());
    return dio;
  }
}

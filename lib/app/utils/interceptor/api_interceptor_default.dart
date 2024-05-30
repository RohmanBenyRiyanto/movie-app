import 'package:dio/dio.dart';
import 'package:movie/app/res/constant/constant.dart';

class ApiInterceptorDefault extends Interceptor {
  final String? token;
  final String language;

  ApiInterceptorDefault({
    this.token,
    required this.language,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add token to header if it's not null
    if (token != null) {
      options.headers[Constant.api.headAuthKey] =
          '${Constant.api.headAuthType} $token';
    }

    // Add language to query parameters
    options.queryParameters[Constant.api.apiLangKey] = language;

    super.onRequest(options, handler);
  }
}

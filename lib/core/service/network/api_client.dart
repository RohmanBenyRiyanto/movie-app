enum HTTPMethod { get, post, put, patch, delete }

extension HTTPMethodExtension on HTTPMethod {
  String get name => toString().split('.').last;
}

abstract class ApiClient {
  String get urlPath;
  HTTPMethod get method;
  Map<String, dynamic>? get headers;
  Map<String, dynamic>? get query;
  dynamic get body;
  bool get useInterceptor;
  Future<dynamic> request();
}

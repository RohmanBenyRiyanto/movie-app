abstract class ApiClient {
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? params,
    bool token = true,
  });

  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? body,
    bool token = true,
    Map<String, dynamic>? params,
  });
}

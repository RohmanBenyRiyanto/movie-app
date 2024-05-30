part of '../constant.dart';

class ApiConstans {
  const ApiConstans();

  //? HEADERS
  String get headAcceptKey => 'accept';
  String get headAcceptValue => 'application/json';
  String get headAuthKey => 'Authorization';
  String get headAuthType => 'Bearer';

  //? PARAMS
  String get apiLangKey => 'language';

  //? TIMEOUT
  Duration get connectionTimeout => const Duration(seconds: 30);
  Duration get receiveTimeout => const Duration(seconds: 30);

  //? HEADERS GROUP
  Map<String, String> get headers => {
        headAcceptKey: headAcceptValue,
      };

  //? API VERSION
  String get v3 => 'v3';

  //? API ENDPOINTS
}

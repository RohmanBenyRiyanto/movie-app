import 'dart:ui';

part 'src/api_constans.dart';
part 'src/app_constans.dart';
part 'src/local_storage_key.dart';

abstract class Constant {
  static const app = AppConstans();
  static const api = ApiConstans();
  static const localKey = LocalStorageKey();
}

library boolean_extension;

extension BooleanExtension on bool {
  /// Convert boolean to string, true -> 1, false -> 0
  String get boolToString => this ? "1" : "0";
}

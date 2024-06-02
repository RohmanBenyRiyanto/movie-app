library double_extension;

extension DoubleExtension on double {
  String formatPopularity() {
    if (this == 0) {
      return "0";
    } else if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}k';
    } else {
      return toStringAsFixed(0);
    }
  }
}

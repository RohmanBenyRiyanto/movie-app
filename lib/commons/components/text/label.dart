import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class Label extends StatelessWidget {
  const Label({
    super.key,
    this.label = '-',
    this.padding,
    this.width,
  });

  final double? width;
  final String label;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: padding ??
          const EdgeInsets.symmetric(horizontal: AppDimens.marginMedium),
      child: Text(
        label,
        textAlign: TextAlign.left,
        style: AppTextStyle.label2Medium,
      ),
    );
  }
}

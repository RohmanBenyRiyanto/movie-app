import 'package:flutter/material.dart';

import '../../../../commons/themes/themes.dart';

class HomeLastView extends StatelessWidget {
  const HomeLastView({
    super.key,
    EdgeInsetsGeometry? padding,
  }) : padding = padding ??
            const EdgeInsets.symmetric(horizontal: AppDimens.marginMedium);

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Last View",
            style: ThemeHelper.getTextTheme.titleMedium,
          ),
          const SizedBox(height: AppDimens.s10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius:
                        BorderRadius.circular(AppDimens.roundedMedium),
                  ),
                ),
              ),
              const SizedBox(width: AppDimens.s16),
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius:
                        BorderRadius.circular(AppDimens.roundedMedium),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

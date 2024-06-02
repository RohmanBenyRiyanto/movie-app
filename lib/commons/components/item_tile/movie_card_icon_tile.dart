import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/res/res.dart';
import '../../themes/themes.dart';

class MovieCardIconTile extends StatelessWidget {
  const MovieCardIconTile({
    super.key,
    required this.iconPath,
    this.iconColor = AppColor.accentLight,
    this.value,
  });

  final String iconPath;
  final Color iconColor;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconPath,
          height: AppDimens.s10,
          colorFilter: ColorFilter.mode(
            iconColor,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: AppDimens.s4),
        Text(
          value ?? "-",
          style: AppTextStyle.caption2Light.copyWith(
            color: AppColor.textSecondary,
          ),
        ),
      ],
    );
  }
}

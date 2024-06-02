import 'package:flutter/material.dart';

import '../../../app/extensions/extensions.dart';
import '../../../app/res/assets.gen.dart';
import '../../../app/res/res.dart';
import '../../../core/service/network/network.dart';
import '../../themes/themes.dart';
import '../image/img.dart';

class CardMovieSmall extends StatelessWidget {
  const CardMovieSmall({
    super.key,
    this.imagePath,
    this.title,
    this.popularity,
    this.onTap,
  });

  final String? imagePath;
  final String? title;
  final double? popularity;
  final VoidCallback? onTap;

  static const double _imageSizeFactor = 0.12;
  static const double _iconSize = AppDimens.iconExtraSmall;

  @override
  Widget build(BuildContext context) {
    final double imageSize =
        MediaQuery.of(context).size.height * _imageSizeFactor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: imageSize,
        decoration: BoxDecoration(
          color: AppColor.background,
          borderRadius: BorderRadius.circular(AppDimens.roundedMedium),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(imageSize),
            const SizedBox(height: AppDimens.s6),
            _buildTitle(),
            const SizedBox(height: AppDimens.s6),
            _buildPopularity(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.roundedMedium),
        border: Border.all(
          color: AppColor.textSecondary.withOpacity(0.5),
          width: 0.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimens.roundedMedium),
        child: Img.network(
          ApiEndpoint.imageUrlW342(imagePath ?? ""),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title ?? "",
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyle.caption1Medium,
    );
  }

  Widget _buildPopularity() {
    return Row(
      children: [
        AppAssets.icons.common.icLike.svg(
          width: _iconSize,
          height: _iconSize,
          colorFilter: const ColorFilter.mode(
            AppColor.accentLight,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: AppDimens.s4),
        Text(
          (popularity ?? 0).formatPopularity(),
          style: AppTextStyle.caption2Light.copyWith(
            color: AppColor.textSecondary,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../app/res/assets.gen.dart';
import '../../../app/res/res.dart';
import '../../../app/utils/utils.dart';
import '../../../core/service/network/network.dart';
import '../../themes/themes.dart';
import '../image/img.dart';
import '../item_tile/movie_card_icon_tile.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    this.title,
    this.image,
    this.releaseDate,
    this.rating,
  });

  final String? title;
  final String? image;
  final String? releaseDate;
  final double? rating;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildImage(),
        _buildGradient(),
        _buildMovieDetails(),
        _buildTag(),
      ],
    );
  }

  Widget _buildImage() {
    return Positioned.fill(
      child: Container(
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
            ApiEndpoint.imageUrlOriginal(image ?? ""),
          ),
        ),
      ),
    );
  }

  Widget _buildGradient() {
    return const Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieDetails() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.s8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? "",
              style: AppTextStyle.label1Medium.copyWith(
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
            const SizedBox(height: AppDimens.s4),
            Row(
              children: [
                MovieCardIconTile(
                  iconPath: AppAssets.icons.common.icStar.path,
                  value: rating?.toStringAsFixed(1) ?? "0.0",
                ),
                const SizedBox(width: AppDimens.s8),
                MovieCardIconTile(
                  iconPath: AppAssets.icons.common.icTime.path,
                  value: DateHandler.instance.ddMMMYYYY(releaseDate),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag() {
    return Positioned(
      top: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(AppDimens.roundedMedium),
        ),
        child: AppAssets.icons.badge.top10Badge.svg(
          width: AppDimens.s24,
        ),
      ),
    );
  }
}

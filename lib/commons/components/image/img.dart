import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../app/res/res.dart';
import '../animations/animation_shimmer.dart';

class Img {
  static CachedNetworkImage network(
    String? url, {
    BoxFit? fit,
    double? height,
    double? width,
  }) {
    return CachedNetworkImage(
      imageUrl: url ?? Constant.app.imagePlaceholder,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          _buildProgressIndicator(),
      errorWidget: (context, url, error) =>
          _buildErrorWidget(url, error, height, width, fit),
    );
  }

  static Widget _buildProgressIndicator() {
    return SizedBox.expand(
      child: Stack(
        children: [
          ShimmerEffect(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColor.secondaryLight,
              ),
            ),
          ),
          Center(
            child: Icon(
              Icons.image_outlined,
              color: AppColor.textPrimary.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildErrorWidget(
      String url, dynamic error, double? height, double? width, BoxFit? fit) {
    if (error.toString().contains("404") || error.toString().contains("400")) {
      return SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColor.secondaryLight,
          ),
          child: Icon(
            Icons.broken_image_outlined,
            color: AppColor.error.withOpacity(0.4),
            size: 24.0,
          ),
        ),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: Constant.app.imagePlaceholder,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      );
    }
  }
}

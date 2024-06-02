import 'package:flutter/material.dart';

import '../../../app/res/assets.gen.dart';
import '../../themes/themes.dart';

class DataNotFound extends StatelessWidget {
  const DataNotFound({
    super.key,
    this.valueSearch,
    this.heightRatio = 0.25,
    this.isSearch = false,
  });

  final bool isSearch;
  final double heightRatio;
  final String? valueSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * heightRatio,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppAssets.images.common.emptyBox.image(width: 184.0),
          const SizedBox(height: AppDimens.marginMedium),
          Text(
            (isSearch && (valueSearch?.isEmpty ?? true))
                ? "Type something to search"
                : "No results found",
            style: AppTextStyle.label2Light,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../app/res/res.dart';
import '../../../../commons/components/components.dart';
import '../../../../commons/themes/themes.dart';
import 'home_last_view.dart';

Future<AppBottomSheet> showMovieDetail(BuildContext context) async {
  return await AppBottomSheet.show(
    context: context,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(AppDimens.roundedMedium),
          ),
        ),
        const SizedBox(height: AppDimens.s12),
        const Text(
          "The Batman",
          style: AppTextStyle.label1Bold,
        ),
        const SizedBox(height: AppDimens.s10),
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sed diam",
          style: AppTextStyle.label3Light.copyWith(
            color: AppColor.textSecondary,
          ),
        ),
        const SizedBox(height: AppDimens.s10),
        const HomeLastView(padding: EdgeInsets.zero),
      ],
    ),
  );
}

import 'package:flutter/material.dart';

import '../../../app/res/res.dart';
import '../../themes/themes.dart';

class LoadingPaging extends StatelessWidget {
  const LoadingPaging(
    this.isLoadMore, {super.key});

  final bool isLoadMore;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppDimens.s16),
        width: isLoadMore ? AppDimens.s20 : 0,
        height: isLoadMore ? AppDimens.s20 : 0,
        child: const CircularProgressIndicator.adaptive(
          strokeWidth: AppDimens.s4,
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.primary),
        ),
      ),
    );
  }
}

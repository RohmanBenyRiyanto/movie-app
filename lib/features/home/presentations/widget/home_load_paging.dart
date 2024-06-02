import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/res/res.dart';
import '../../../../commons/themes/themes.dart';
import '../view_model/get_by_category/get_by_category_cubit.dart';

class HomeLoadPaging extends StatelessWidget {
  const HomeLoadPaging({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetByCategoryCubit, GetByCategoryState>(
      builder: (context, state) {
        final isLoadMore = state.maybeWhen(
          success: (_, isLoadMore, __) => isLoadMore,
          orElse: () => false,
        );

        return _buildIndicator(isLoadMore);
      },
    );
  }

  Widget _buildIndicator(bool isLoadMore) {
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

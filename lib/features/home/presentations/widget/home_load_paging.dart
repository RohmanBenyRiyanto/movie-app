import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../commons/components/components.dart';
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

        return LoadingPaging(isLoadMore);
      },
    );
  }


}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../commons/components/components.dart';
import '../view_model/search_cubit.dart';

class SearchLoadPaging extends StatelessWidget {
  const SearchLoadPaging({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit,  SearchState>(
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

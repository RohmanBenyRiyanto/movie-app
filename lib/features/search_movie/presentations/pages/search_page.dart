import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../commons/components/components.dart';
import '../../../../commons/themes/themes.dart';
import '../../../../core/injections/injection.dart';
import '../../domain/entity/search_movie_entity.dart';
import '../view_model/search_cubit.dart';
import '../widget/search_item.dart';
import '../widget/search_load_paging.dart';
import '../widget/search_placeholder.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchCtrl = TextEditingController();
  final _searchCubit = locator<SearchCubit>();

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchCtrl.removeListener(_onSearchChanged);
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      blocProviders: [
        BlocProvider<SearchCubit>(create: (context) => _searchCubit),
      ],
      onLoadMore: () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          await _searchCubit.fetchMoreData();
        });
      },
      appBar: (_) => AppBar(
        toolbarHeight: 66,
        leadingWidth: 0,
        titleSpacing: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          children: [
            const SizedBox(width: AppDimens.s4),
            ButtonIcon(
              iconData: Icons.arrow_back_ios_rounded,
              onPressed: () => context.pop(),
            ),
            const SizedBox(width: AppDimens.s10),
            Expanded(
              child: FormSearch(
                controller: _searchCtrl,
                onFieldSubmitted: (value) async {
                  await _searchCubit.fetchData(value);
                },
              ),
            ),
            const SizedBox(width: AppDimens.s16),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.marginMedium,
        ),
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            final List<ResultEntity>? data = state.maybeWhen(
              orElse: () => [],
              success: (data, _, __) => data,
            );

            final isLoading = state.maybeWhen(
              orElse: () => false,
              loading: () => true,
            );

            final isEmpty = data?.isEmpty ?? true;

            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SearchPlaceholder(value: _searchCtrl.text),
                if (!isLoading && !isEmpty && _searchCtrl.text.isNotEmpty) ...[
                  SearchItem(data: data),
                ] else ...[
                  DataNotFound(
                    isSearch: true,
                    valueSearch: _searchCtrl.text,
                  )
                ],
                const SearchLoadPaging()
              ],
            );
          },
        ),
      ),
    );
  }
}

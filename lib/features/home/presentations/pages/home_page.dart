import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../../../commons/components/components.dart';
import '../../../../commons/themes/themes.dart';
import '../../../../core/injections/injection.dart';
import '../view_model/genres/get_genres_cubit.dart';
import '../view_model/genres/select_category_cubit.dart';
import '../view_model/get_by_category/get_by_category_cubit.dart';
import '../view_model/now_playing/get_now_playing_cubit.dart';
import '../view_model/popular/popular_cubit.dart';
import '../widget/home_by_category.dart';
import '../widget/home_last_view.dart';
import '../widget/home_load_paging.dart';
import '../widget/home_popular.dart';
import '../widget/home_now_playing.dart';

class HomePage extends BaseScrollPage {
  const HomePage({super.key});

  @override
  BaseScrollPageState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseScrollPageState<HomePage> {
  final _genresCubit = locator<GetGenresCubit>();
  final _popularCubit = locator<PopularCubit>();
  final _nowPlayingCubit = locator<GetNowPlayingCubit>();
  final _selectCategoryCubit = locator<SelectCategoryCubit>();
  final _getByCategoryCubit = locator<GetByCategoryCubit>();

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _genresCubit.fetchData();
      await _popularCubit.fetchData();
      await _nowPlayingCubit.fetchData();
    });
    super.onInit();
  }

  @override
  void onLoadMore() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getByCategoryCubit.fetchMoreData();
    });
    super.onLoadMore();
  }

  @override
  List<SingleChildWidget> blocProviders(BuildContext context) {
    return [
      BlocProvider(create: (context) => _popularCubit),
      BlocProvider(create: (context) => _genresCubit),
      BlocProvider(create: (context) => _nowPlayingCubit),
      BlocProvider(create: (context) => _selectCategoryCubit),
      BlocProvider(create: (context) => _getByCategoryCubit),
    ];
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context, bool isScroll) {
    return AppBarDefault(
      title: "Ngepilem",
      onTrailingIconPressed: () {},
      isScroll: isScroll,
    );
  }

  @override
  Widget buildBody(BuildContext context, bool isScroll) {
    return const Column(
      children: [
        SizedBox(height: AppDimens.s10),
        HomePopular(),
        SizedBox(height: AppDimens.s16),
        HomeLastView(),
        SizedBox(height: AppDimens.s16),
        HomeNowPlaying(),
        SizedBox(height: AppDimens.s16),
        HomeByCategory(),
        HomeLoadPaging(),
      ],
    );
  }
}

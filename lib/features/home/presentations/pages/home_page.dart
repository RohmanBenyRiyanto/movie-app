import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../commons/components/components.dart';
import '../../../../commons/themes/themes.dart';
import '../../../../core/injections/injection.dart';
import '../../../../core/routes/routes.dart';
import '../view_model/genres/get_genres_cubit.dart';
import '../view_model/genres/select_category_cubit.dart';
import '../view_model/get_by_category/get_by_category_cubit.dart';
import '../view_model/now_playing/get_now_playing_cubit.dart';
import '../view_model/popular/popular_cubit.dart';
import '../widget/home_by_category.dart';
import '../widget/home_last_view.dart';
import '../widget/home_load_paging.dart';
import '../widget/home_now_playing.dart';
import '../widget/home_popular.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final genresCubit = locator<GetGenresCubit>();
    final popularCubit = locator<PopularCubit>();
    final nowPlayingCubit = locator<GetNowPlayingCubit>();
    final selectCategoryCubit = locator<SelectCategoryCubit>();
    final getByCategoryCubit = locator<GetByCategoryCubit>();

    return BasePage(
      blocProviders: [
        BlocProvider(create: (context) => popularCubit),
        BlocProvider(create: (context) => genresCubit),
        BlocProvider(create: (context) => nowPlayingCubit),
        BlocProvider(create: (context) => selectCategoryCubit),
        BlocProvider(create: (context) => getByCategoryCubit),
      ],
      onInit: () {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await genresCubit.fetchData();
          await popularCubit.fetchData();
          await nowPlayingCubit.fetchData();
        });
      },
      onLoadMore: () {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await getByCategoryCubit.fetchMoreData();
        });
      },
      appBar: (isScroll) => AppBarDefault(
        isScroll: isScroll,
        title: "Ngepilem",
        onTrailingIconPressed: () =>
            navKey.currentContext!.push(RoutePath.search),
      ),
      body: const Column(
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
      ),
    );
  }
}

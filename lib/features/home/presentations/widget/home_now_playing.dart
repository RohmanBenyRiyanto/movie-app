import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../commons/components/components.dart';
import '../../../../commons/themes/themes.dart';
import '../../../../core/service/network/network.dart';
import '../view_model/now_playing/get_now_playing_cubit.dart';

class HomeNowPlaying extends StatelessWidget {
  const HomeNowPlaying({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Label(label: "Now Playing"),
        const SizedBox(height: AppDimens.s10),
        BlocBuilder<GetNowPlayingCubit, GetNowPlayingState>(
          builder: (context, state) {
            final data = state.maybeWhen(
              orElse: () => null,
              success: (data, _, __) => data,
            );

            final hasNextPage = state.maybeWhen(
              orElse: () => false,
              success: (_, isLoadMore, hasNextPage) => hasNextPage,
            );

            return CarouselHorizontal(
              hasMore: hasNextPage,
              offsetLoading:
                  Offset(0, -MediaQuery.of(context).size.height * 0.02),
              itemCount: data?.length ?? 0,
              onLoadMore: () async =>
                  await context.read<GetNowPlayingCubit>().fetchMoreData(),
              itemBuilder: (ctx, index) {
                final item = data?[index];
                return CardMovieSmall(
                  imagePath: ApiEndpoint.imageUrlW342(item?.posterPath ?? ""),
                  title: item?.title,
                  popularity: item?.popularity,
                  onTap: () {},
                );
              },
            );
          },
        ),
      ],
    );
  }
}

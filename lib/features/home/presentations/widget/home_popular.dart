import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/commons/themes/themes.dart';

import '../../../../commons/components/components.dart';
import '../view_model/popular/popular_cubit.dart';

class HomePopular extends StatelessWidget {
  const HomePopular({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularCubit, PopularState>(
      builder: (context, state) {
        final data = state.maybeWhen(
          orElse: () => null,
          success: (data) => data,
        );

        return CarouselDots(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: index != -1 ? AppDimens.s16 : 0),
              child: MovieCard(
                title: data?.results?[index].title ?? "",
                image: data?.results?[index].posterPath ?? "",
                releaseDate: data?.results?[index].releaseDate ?? "",
                rating: data?.results?[index].voteAverage ?? 0.0,
              ),
            );
          },
        );
      },
    );
  }
}

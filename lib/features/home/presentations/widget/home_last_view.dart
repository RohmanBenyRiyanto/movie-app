import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/app/res/colors.gen.dart';
import 'package:movie/commons/components/components.dart';
import 'package:movie/core/service/network/network.dart';
import 'package:movie/features/home/presentations/view_model/now_playing/get_now_playing_cubit.dart';

import '../../../../commons/themes/themes.dart';

class HomeLastView extends StatelessWidget {
  const HomeLastView({
    super.key,
    EdgeInsetsGeometry? padding,
  }) : padding = padding ??
            const EdgeInsets.symmetric(horizontal: AppDimens.marginMedium);

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Last View",
            style: ThemeHelper.getTextTheme.titleMedium,
          ),
          const SizedBox(height: AppDimens.s10),
          BlocBuilder<GetNowPlayingCubit, GetNowPlayingState>(
            builder: (context, state) {
              final data = state.maybeWhen(
                orElse: () => null,
                success: (data, _, __) => data,
              );

              if (data == null || (data.length <= 2)) {
                return const SizedBox();
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColor.surface,
                        borderRadius:
                            BorderRadius.circular(AppDimens.roundedMedium),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppDimens.roundedMedium),
                        child: Img.network(
                          ApiEndpoint.imageUrlW300(data[0].backdropPath ?? "-"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimens.s16),
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColor.surface,
                        borderRadius:
                            BorderRadius.circular(AppDimens.roundedMedium),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppDimens.roundedMedium),
                        child: Img.network(
                          ApiEndpoint.imageUrlW300(
                            data[1].backdropPath ?? "-",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

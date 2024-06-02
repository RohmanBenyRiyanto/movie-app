import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/res/res.dart';
import '../../../../commons/components/components.dart';
import '../../../../commons/components/image/img.dart';
import '../../../../commons/themes/themes.dart';
import '../../../../core/service/network/network.dart';
import '../../domain/entity/genres_entity.dart';
import '../view_model/genres/get_genres_cubit.dart';
import '../view_model/genres/select_category_cubit.dart';
import '../view_model/get_by_category/get_by_category_cubit.dart';
import 'home_select_category.dart';

class HomeByCategory extends StatelessWidget {
  const HomeByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetGenresCubit, GetGenresState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (data) => context.read<SelectCategoryCubit>().select(
                data.genres?.first ?? GenreDataEntity(),
              ),
          orElse: () => null,
        );
      },
      builder: (context, state) {
        final genres = state.maybeWhen(
          success: (data) => data.genres,
          orElse: () => null,
        );

        return Column(
          children: [
            _buildHeader(context, genres),
            const SizedBox(height: AppDimens.s12),
            _buildCategoryGrid(),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, List<GenreDataEntity>? genres) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Label(label: "Categories", width: 0.0),
        Padding(
          padding: const EdgeInsets.only(right: AppDimens.s10),
          child: BlocConsumer<SelectCategoryCubit, SelectCategoryState>(
            listener: (context, state) {
              state.maybeWhen(
                selected: (selected) =>
                    context.read<GetByCategoryCubit>().fetchData(selected!),
                orElse: () => null,
              );
            },
            builder: (context, state) {
              final selectedCategory = state.maybeWhen(
                selected: (selected) => selected,
                orElse: () => null,
              );

              return InkWell(
                onTap: () async => await HomeSelectCategory.instance.show(
                  context,
                  genres: genres,
                  selectedCategory: selectedCategory,
                ),
                borderRadius:
                    BorderRadius.circular(AppDimens.roundedExtraLarge),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.s6,
                    vertical: AppDimens.s2,
                  ),
                  child: Row(
                    children: [
                      Text(
                        selectedCategory?.name ?? "-",
                        style: AppTextStyle.caption1Light.copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                      const SizedBox(width: AppDimens.s4),
                      Transform.rotate(
                        angle: 90 * math.pi / 180,
                        child: const Icon(
                          CupertinoIcons.chevron_right,
                          color: AppColor.textSecondary,
                          size: AppDimens.iconExtraSmall,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryGrid() {
    return BlocBuilder<GetByCategoryCubit, GetByCategoryState>(
      builder: (context, state) {
        final data = state.maybeWhen(
          success: (data, _, __) => data,
          orElse: () => null,
        );

        return GridView.builder(
          shrinkWrap: true,
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimens.marginMedium),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: AppDimens.s10,
            crossAxisSpacing: AppDimens.s10,
            childAspectRatio: 0.7,
          ),
          itemCount: data?.length ?? 0,
          itemBuilder: (context, index) {
            final item = data?[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.roundedMedium),
                border: Border.all(
                  color: AppColor.textSecondary.withOpacity(0.5),
                  width: 0.5,
                ),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.roundedMedium),
                child: Img.network(
                  ApiEndpoint.imageUrlW342(item?.posterPath ?? ""),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

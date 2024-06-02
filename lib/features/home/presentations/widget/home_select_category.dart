import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/home/domain/entity/genres_entity.dart';

import '../../../../app/res/res.dart';
import '../../../../commons/components/components.dart';
import '../../../../commons/themes/themes.dart';
import '../view_model/genres/select_category_cubit.dart';

class HomeSelectCategory {
  HomeSelectCategory._();
  static HomeSelectCategory? _instance;
  static HomeSelectCategory get instance =>
      _instance ??= HomeSelectCategory._();

  Future<AppBottomSheet> show(
    BuildContext context, {
    List<GenreDataEntity>? genres,
    GenreDataEntity? selectedCategory,
  }) {
    return AppBottomSheet.show(
      context: context,
      title: "Choose category",
      fullScreen: true,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          genres?.length ?? 0,
          (index) => InkWell(
            onTap: () {
              Navigator.pop(context);
              context.read<SelectCategoryCubit>().select(genres[index]);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: AppDimens.s14,
              ),
              color: Colors.transparent,
              child: Text(
                genres?[index].name ?? "-",
                textAlign: TextAlign.left,
                style: genres![index] == selectedCategory
                    ? AppTextStyle.label3Medium
                        .copyWith(color: AppColor.primary)
                    : AppTextStyle.label3Light.copyWith(
                        color: AppColor.textSecondary,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

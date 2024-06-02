import 'package:flutter/material.dart';

import '../../../../app/res/res.dart';
import '../../../../commons/components/components.dart';
import '../../../../commons/themes/themes.dart';
import '../../../../core/service/network/network.dart';
import '../../domain/entity/search_movie_entity.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key, this.data});

  final List<ResultEntity>? data;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: AppDimens.marginMedium),
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
              ApiEndpoint.imageUrlW342(item?.posterPath ?? ''),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

import '../../../commons/themes/themes.dart';
import 'home_show_detail.dart';

class HomeByCategory extends StatelessWidget {
  const HomeByCategory({
    super.key,
    this.label = "Label",
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimens.marginMedium),
          child: Text(
            label,
            style: ThemeHelper.getTextTheme.titleMedium,
          ),
        ),
        const SizedBox(height: AppDimens.s10),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: InfiniteCarousel.builder(
            center: false,
            loop: false,
            itemCount: 10,
            velocityFactor: 0.1,
            itemExtent: MediaQuery.of(context).size.width * 0.5 - AppDimens.s8,
            onIndexChanged: (index) {},
            axisDirection: Axis.horizontal,
            itemBuilder: (context, itemIndex, realIndex) {
              return GestureDetector(
                onTap: () async => await showMovieDetail(context),
                child: Container(
                  margin: EdgeInsets.only(
                    left: itemIndex == 0 ? AppDimens.s20 : AppDimens.s16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius:
                        BorderRadius.circular(AppDimens.roundedMedium),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

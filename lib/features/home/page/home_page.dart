import 'package:flutter/material.dart';

import '../../../commons/components/components.dart';
import '../../../commons/themes/themes.dart';
import '../widget/home_by_category.dart';
import '../widget/home_last_view.dart';

class HomePage extends BasePage {
  const HomePage({super.key});

  @override
  BasePageState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage> {
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
        CarouselDots(),
        SizedBox(height: AppDimens.s16),
        HomeLastView(),
        SizedBox(height: AppDimens.s16),
        HomeByCategory(label: "Action"),
        SizedBox(height: AppDimens.s16),
        HomeByCategory(label: "Comedy"),
        SizedBox(height: AppDimens.s16),
        HomeByCategory(label: "Drama"),
        SizedBox(height: AppDimens.s16),
      ],
    );
  }
}

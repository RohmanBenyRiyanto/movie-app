import 'package:flutter/material.dart';

import '../../../../app/res/res.dart';
import '../../../../commons/themes/themes.dart';

class SearchPlaceholder extends StatelessWidget {
  const SearchPlaceholder(
   {
    super.key,
    this.value, 
  });

  final String? value;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: (value?.isNotEmpty ?? false) ? 1.0 : 0.0,
      duration: Constant.app.animatedDuration,
      child: AnimatedContainer(
        duration: Constant.app.animatedListDuration,
        height:  (value?.isNotEmpty ?? false) ? 24 : 0,
        child: RichText(
          text: TextSpan(
            text: "Search: ",
            style: AppTextStyle.label2Medium,
            children: [
              TextSpan(
                text:  value,
                style: AppTextStyle.label2Light,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

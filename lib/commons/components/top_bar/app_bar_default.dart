import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/res/assets.gen.dart';
import '../../../app/res/res.dart';
import '../../themes/themes.dart';
import '../components.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final TextStyle? titleTextStyle;
  final IconData leadingIcon;
  final VoidCallback? onLeadingIconPressed;
  final VoidCallback? onTrailingIconPressed;
  final bool isScroll;

  const AppBarDefault({
    super.key,
    this.title = 'Title',
    this.backgroundColor,
    this.titleTextStyle,
    this.leadingIcon = Icons.menu_rounded,
    this.onLeadingIconPressed,
    this.onTrailingIconPressed,
    this.isScroll = false,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop ?? false;
    return Material(
      color: isScroll ? Colors.transparent : backgroundColor,
      child: AppBar(
        leading: null,
        leadingWidth: 0,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor:
            isScroll ? AppColor.background.withOpacity(0.9) : backgroundColor,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: AppDimens.s10),
                ButtonIcon(
                  size: canPop ? AppDimens.s22 : null,
                  onPressed: canPop
                      ? () {
                          context.pop();
                        }
                      : onLeadingIconPressed,
                  iconData:
                      canPop ? Icons.arrow_back_ios_new_rounded : leadingIcon,
                ),
                const SizedBox(width: AppDimens.paddingExtraSmall),
                Text(
                  title,
                  style: titleTextStyle ??
                      ThemeHelper.getTextTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeights.medium,
                      ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: AppDimens.paddingExtraSmall),
                ButtonIcon(
                  onPressed: onTrailingIconPressed,
                  iconPath: AppAssets.icons.common.icSearch.path,
                ),
                const SizedBox(width: AppDimens.s16),
              ],
            ),
          ],
        ),
        flexibleSpace: isScroll
            ? ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              )
            : null,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(isScroll ? 1 : 0),
          child: AnimatedContainer(
            duration: Constant.app.animatedDuration,
            height: isScroll ? 0.5 : 0,
            color: AppColor.secondaryLight.withOpacity(1),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

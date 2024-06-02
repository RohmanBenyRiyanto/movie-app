import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? iconSize;
  final double padding;
  final String? iconPath;
  final IconData? iconData;
  final Color? color;
  final double? size;
  final double? buttonSize;
  final Color buttonColor;
  final BoxFit fit;

  static const double defaultSmallIconSize = 16.0;
  static const double defaultMediumIconSize = 20.0;
  static const double defaultLargeIconSize = 24.0;
  static const double defaultSmallButtonSize = 24.0;
  static const double defaultMediumButtonSize = 32.0;
  static const double defaultLargeButtonSize = 40.0;
  static const double defaultSmallPadding = 4.0;
  static const double defaultMediumPadding = 4.0;
  static const double defaultLargePadding = 8.0;
  static const Color defaultButtonColor = Colors.transparent;

  const ButtonIcon({
    super.key,
    required this.onPressed,
    this.iconSize = defaultLargeIconSize,
    this.padding = defaultLargePadding,
    this.buttonSize = defaultLargeButtonSize,
    this.size = defaultLargeIconSize,
    this.iconPath,
    this.iconData,
    this.color,
    this.fit = BoxFit.scaleDown,
    this.buttonColor = defaultButtonColor,
  }) : assert(
          (iconPath != null && iconData == null) ||
              (iconPath == null && iconData != null),
          'You must provide either an iconPath (.svg/png) or iconData, not both.',
        );

  factory ButtonIcon.small(
      {required VoidCallback? onPressed,
      String? iconPath,
      IconData? iconData,
      Color? color,
      double? size,
      BoxFit fit = BoxFit.scaleDown,
      Color buttonColor = defaultButtonColor}) {
    return ButtonIcon(
      onPressed: onPressed,
      iconSize: defaultSmallIconSize,
      buttonSize: defaultSmallButtonSize,
      padding: defaultSmallPadding,
      iconPath: iconPath,
      iconData: iconData,
      color: color,
      size: size,
      fit: fit,
      buttonColor: buttonColor,
    );
  }

  factory ButtonIcon.medium(
      {required VoidCallback? onPressed,
      String? iconPath,
      IconData? iconData,
      Color? color,
      double? size,
      BoxFit fit = BoxFit.scaleDown,
      Color buttonColor = defaultButtonColor}) {
    return ButtonIcon(
      onPressed: onPressed,
      iconSize: defaultMediumIconSize,
      buttonSize: defaultMediumButtonSize,
      padding: defaultMediumPadding,
      iconPath: iconPath,
      iconData: iconData,
      color: color,
      size: size,
      fit: fit,
      buttonColor: buttonColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget iconWidget;
    if (iconPath != null) {
      iconWidget = iconPath!.endsWith('.svg')
          ? SvgPicture.asset(
              iconPath!,
              fit: fit,
              width: size ?? iconSize,
              height: size ?? iconSize,
              colorFilter: ColorFilter.mode(
                color ?? Theme.of(context).colorScheme.onBackground,
                BlendMode.srcIn,
              ),
            )
          : Image.asset(
              iconPath!,
              fit: fit,
              width: size ?? iconSize,
              height: size ?? iconSize,
              color: color,
            );
    } else {
      iconWidget = Icon(
        iconData,
        color: color ?? Theme.of(context).colorScheme.onBackground,
        size: size ?? iconSize,
      );
    }

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(buttonSize! * 2.0),
      child: Container(
        width: buttonSize,
        height: buttonSize,
        padding: EdgeInsets.all(padding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor,
          shape: BoxShape.circle,
        ),
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: iconWidget,
        ),
      ),
    );
  }
}

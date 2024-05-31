import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../app/res/res.dart';
import '../../themes/themes.dart';
import '../components.dart';

class AppBottomSheet implements PersistentBottomSheetController {
  final BuildContext context;
  final VoidCallback _onClose;
  final Future<void> _closed;
  final Color backgroundColor;
  final ShapeBorder? shape;
  final BoxConstraints? constraints;
  final bool isScrollControlled;
  final bool useSafeArea;

  AppBottomSheet({
    required this.context,
    required VoidCallback onClose,
    required Future<void> closed,
    this.backgroundColor = Colors.transparent,
    this.shape,
    this.constraints,
    this.isScrollControlled = true,
    this.useSafeArea = true,
  })  : _onClose = onClose,
        _closed = closed;

  @override
  VoidCallback get close => _onClose;

  @override
  Future<void> get closed => _closed;

  @override
  StateSetter? get setState => null;

  static Future<AppBottomSheet> show<T>({
    required BuildContext context,
    Color backgroundColor = Colors.transparent,
    required Widget Function(BuildContext context) builder,
    ShapeBorder? shape,
    BoxConstraints? constraints,
    bool isScrollControlled = true,
    bool useSafeArea = true,
  }) async {
    final completer = Completer<void>();

    showModalBottomSheet<void>(
      useSafeArea: useSafeArea,
      isScrollControlled: isScrollControlled,
      context: context,
      backgroundColor: Colors.transparent,
      constraints: constraints ?? _defaultConstraints(context),
      shape: shape ?? _defaultShape,
      builder: (context) {
        return _buildBottomSheetContent(context, builder, backgroundColor);
      },
    ).whenComplete(() {
      completer.complete();
    });

    return AppBottomSheet(
      context: context,
      onClose: () {
        Navigator.of(context).pop();
      },
      closed: completer.future,
      backgroundColor: backgroundColor,
      shape: shape,
      constraints: constraints,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
    );
  }

  static BoxConstraints _defaultConstraints(BuildContext context) {
    return BoxConstraints(
      minWidth: 0,
      minHeight: 0,
      maxWidth: MediaQuery.of(context).size.width,
      maxHeight: MediaQuery.of(context).size.height * 0.9,
    );
  }

  static ShapeBorder get _defaultShape {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDimens.roundedLarge),
      ),
    );
  }

  static Widget _buildBottomSheetContent(BuildContext context,
      Widget Function(BuildContext context) builder, Color backgroundColor) {
    return IntrinsicHeight(
      child: Stack(
        children: [
          _buildBackdropFilter(),
          _buildContentContainer(context, builder, backgroundColor),
        ],
      ),
    );
  }

  static Widget _buildBackdropFilter() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.background.withOpacity(0.8),
          borderRadius: BorderRadius.circular(AppDimens.roundedLarge),
          border: Border.all(
            color: AppColor.textSecondary.withOpacity(0.1),
            width: 1.0,
          ),
        ),
      ),
    );
  }

  static Widget _buildContentContainer(BuildContext context,
      Widget Function(BuildContext context) builder, Color backgroundColor) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimens.marginSmall,
        left: AppDimens.marginLarge,
        right: AppDimens.marginLarge,
        bottom: AppDimens.marginLarge,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCloseButton(context),
          const SizedBox(height: AppDimens.s6),
          Expanded(child: SingleChildScrollView(child: builder(context))),
        ],
      ),
    );
  }

  static Widget _buildCloseButton(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Transform.translate(
            offset: const Offset(10, 0),
            child: ButtonIcon(
              onPressed: () {
                Navigator.pop(context);
              },
              iconData: Icons.close_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

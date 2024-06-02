import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum TransitionType { slide, fade }

CustomTransitionPage transition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  TransitionType type = TransitionType.fade,
}) {
  switch (type) {
    case TransitionType.slide:
      return CustomTransitionPage<T>(
        key: state.pageKey,
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut))),
          child: child,
        ),
      );
    case TransitionType.fade:
      return CustomTransitionPage<T>(
        key: state.pageKey,
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );
  }
}

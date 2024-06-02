import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/base/app_error.dart';
import '../../features/home/presentations/pages/home_page.dart';
import '../../features/search_movie/presentations/pages/search_page.dart';
import 'transitions/transition.dart';

part 'routes_path.dart';

final navKey = GlobalKey<NavigatorState>();
final snackKey = GlobalKey<ScaffoldMessengerState>();

class AppRoute {
  AppRoute._internal();

  factory AppRoute() => _instance;
  static final AppRoute _instance = AppRoute._internal();

  static final GoRouter _router = GoRouter(
    navigatorKey: navKey,
    debugLogDiagnostics: true,
    routes: routeBase,
    errorBuilder: (BuildContext context, GoRouterState state) =>
        const AppError(),
  );

  static List<RouteBase> routeBase = <RouteBase>[
    GoRoute(
      path: RoutePath.root,
      // builder: (BuildContext context, GoRouterState state) => const HomePage(),
      pageBuilder: (context, state) => transition(
        context: context,
        state: state,
        child: const HomePage(),
        type: TransitionType.fade,
      ),
    ),
    GoRoute(
      path: RoutePath.search,
      // builder: (BuildContext context, GoRouterState state) =>
      //     const SearchPage(),),
      pageBuilder: (context, state) => transition(
        context: context,
        state: state,
        child: const SearchPage(),
        type: TransitionType.slide,
      ),
    ),
  ];

  static GoRouter getRoute(String initialLocation) => GoRouter(
        navigatorKey: navKey,
        debugLogDiagnostics: true,
        routes: routeBase,
        initialLocation: initialLocation,
        errorBuilder: (BuildContext context, GoRouterState state) =>
            const AppError(),
      );

  static GoRouter get router => _router;
}

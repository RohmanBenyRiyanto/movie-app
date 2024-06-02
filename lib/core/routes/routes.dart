import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/base/app_error.dart';
import '../../features/home/presentations/pages/home_page.dart';

part 'routes_path.dart';

final navKey = GlobalKey<NavigatorState>();
final snackKey = GlobalKey<ScaffoldMessengerState>();

class RoutingSetting {
  factory RoutingSetting() => _instance;

  static final RoutingSetting _instance = RoutingSetting._internal();

  RoutingSetting._internal({
    String? initialRoutes,
  }) : initialRoute = initialRoutes ?? RoutePath.root;

  final String initialRoute;

  GoRouter get router => GoRouter(
        navigatorKey: navKey,
        initialLocation: initialRoute,
        debugLogDiagnostics: true,
        routes: <RouteBase>[
          GoRoute(
            path: RoutePath.root,
            name: RoutePath.root,
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
            // pageBuilder: (context, state) =>
            //     MaterialPage(child: const HomePage()),
          ),
        ],
        errorBuilder: (context, state) => AppError(error: state.toString()),
      );
}

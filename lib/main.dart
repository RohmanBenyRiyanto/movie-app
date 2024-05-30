import 'dart:async';

import 'package:flutter/material.dart';

import 'app/base/app.dart';
import 'app/base/app_initial.dart';

void main() => Main();

class Main extends AppInitial {
  @override
  FutureOr<StatelessWidget> onCreate() {
    ErrorWidget.builder = (details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      return const SizedBox.shrink();
    };
    return const App();
  }
}

import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  const AppError({super.key, this.error});

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Something went wrong'),
      ),
      body: Text(error ?? 'Something went wrong'),
    );
  }
}

import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/theme/design_system.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MilesMap',
      theme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}

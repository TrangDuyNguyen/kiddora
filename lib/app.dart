import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'core/constants/app_strings.dart';
import 'core/network/network_inspector_overlay.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class KiddoraApp extends StatelessWidget {
  const KiddoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter().config(),
      builder: (context, child) {
        final content = child ?? const SizedBox.shrink();
        if (!kDebugMode) return content;
        return NetworkInspectorOverlay(child: content);
      },
    );
  }
}

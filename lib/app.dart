import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'features/home/presentation/home_screen.dart';

class KiddoraApp extends StatelessWidget {
  const KiddoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}

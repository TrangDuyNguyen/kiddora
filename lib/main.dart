import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'features/onboarding/presentation/controllers/onboarding_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Pre-warm SharedPreferences đồng bộ theo ADR-001 để đạt SLA Cold Start <= 1.8s
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const KiddoraApp(),
    ),
  );
}

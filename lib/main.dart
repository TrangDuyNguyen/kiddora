import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'features/onboarding/presentation/controllers/onboarding_controller.dart';

Future<void> main() async {
  // Preserve native splash while Flutter initializes (ADR-001: cold start <= 1.8s).
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  final prefs = await SharedPreferences.getInstance();

  // Remove native splash once Flutter is ready — SplashScreen takes over.
  FlutterNativeSplash.remove();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const KiddoraApp(),
    ),
  );
}

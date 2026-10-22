// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:kiddora/features/auth/presentation/login_screen.dart' as _i3;
import 'package:kiddora/features/auth/presentation/register_screen.dart' as _i5;
import 'package:kiddora/features/home/presentation/home_screen.dart' as _i1;
import 'package:kiddora/features/home/presentation/today_learning_goal_screen.dart'
    as _i7;
import 'package:kiddora/features/onboarding/presentation/pages/kid_profile_setup_screen.dart'
    as _i2;
import 'package:kiddora/features/onboarding/presentation/pages/onboarding_screen.dart'
    as _i4;
import 'package:kiddora/features/splash/presentation/pages/splash_screen.dart'
    as _i6;

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeScreen();
    },
  );
}

/// generated route for
/// [_i2.KidProfileSetupScreen]
class KidProfileSetupRoute extends _i8.PageRouteInfo<void> {
  const KidProfileSetupRoute({List<_i8.PageRouteInfo>? children})
    : super(KidProfileSetupRoute.name, initialChildren: children);

  static const String name = 'KidProfileSetupRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.KidProfileSetupScreen();
    },
  );
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute({List<_i8.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginScreen();
    },
  );
}

/// generated route for
/// [_i4.OnboardingScreen]
class OnboardingRoute extends _i8.PageRouteInfo<OnboardingRouteArgs> {
  OnboardingRoute({
    _i9.Key? key,
    int initialPage = 0,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         OnboardingRoute.name,
         args: OnboardingRouteArgs(key: key, initialPage: initialPage),
         initialChildren: children,
       );

  static const String name = 'OnboardingRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnboardingRouteArgs>(
        orElse: () => const OnboardingRouteArgs(),
      );
      return _i4.OnboardingScreen(key: args.key, initialPage: args.initialPage);
    },
  );
}

class OnboardingRouteArgs {
  const OnboardingRouteArgs({this.key, this.initialPage = 0});

  final _i9.Key? key;

  final int initialPage;

  @override
  String toString() {
    return 'OnboardingRouteArgs{key: $key, initialPage: $initialPage}';
  }
}

/// generated route for
/// [_i5.RegisterScreen]
class RegisterRoute extends _i8.PageRouteInfo<void> {
  const RegisterRoute({List<_i8.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i6.SplashScreen]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute({List<_i8.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.SplashScreen();
    },
  );
}

/// generated route for
/// [_i7.TodayLearningGoalScreen]
class TodayLearningGoalRoute extends _i8.PageRouteInfo<void> {
  const TodayLearningGoalRoute({List<_i8.PageRouteInfo>? children})
    : super(TodayLearningGoalRoute.name, initialChildren: children);

  static const String name = 'TodayLearningGoalRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.TodayLearningGoalScreen();
    },
  );
}

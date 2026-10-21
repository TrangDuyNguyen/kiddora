// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:kiddora/features/home/presentation/home_screen.dart' as _i1;
import 'package:kiddora/features/onboarding/presentation/pages/kid_profile_setup_screen.dart'
    as _i2;
import 'package:kiddora/features/onboarding/presentation/pages/onboarding_screen.dart'
    as _i3;

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeScreen();
    },
  );
}

/// generated route for
/// [_i2.KidProfileSetupScreen]
class KidProfileSetupRoute extends _i4.PageRouteInfo<void> {
  const KidProfileSetupRoute({List<_i4.PageRouteInfo>? children})
      : super(KidProfileSetupRoute.name, initialChildren: children);

  static const String name = 'KidProfileSetupRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.KidProfileSetupScreen();
    },
  );
}

/// generated route for
/// [_i3.OnboardingScreen]
class OnboardingRoute extends _i4.PageRouteInfo<OnboardingRouteArgs> {
  OnboardingRoute({
    _i5.Key? key,
    int initialPage = 0,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          OnboardingRoute.name,
          args: OnboardingRouteArgs(key: key, initialPage: initialPage),
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnboardingRouteArgs>(
        orElse: () => const OnboardingRouteArgs(),
      );
      return _i3.OnboardingScreen(key: args.key, initialPage: args.initialPage);
    },
  );
}

class OnboardingRouteArgs {
  const OnboardingRouteArgs({this.key, this.initialPage = 0});

  final _i5.Key? key;

  final int initialPage;

  @override
  String toString() {
    return 'OnboardingRouteArgs{key: $key, initialPage: $initialPage}';
  }
}

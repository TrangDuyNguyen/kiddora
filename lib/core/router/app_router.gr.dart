// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:kiddora/features/auth/presentation/login_screen.dart' as _i8;
import 'package:kiddora/features/auth/presentation/register_screen.dart'
    as _i10;
import 'package:kiddora/features/exploration/presentation/all_courses_grid_screen.dart'
    as _i1;
import 'package:kiddora/features/exploration/presentation/course_curriculum_screen.dart'
    as _i2;
import 'package:kiddora/features/exploration/presentation/course_detail_screen.dart'
    as _i3;
import 'package:kiddora/features/exploration/presentation/course_filter_sheet.dart'
    as _i4;
import 'package:kiddora/features/exploration/presentation/course_search_screen.dart'
    as _i5;
import 'package:kiddora/features/home/presentation/home_screen.dart' as _i6;
import 'package:kiddora/features/home/presentation/today_learning_goal_screen.dart'
    as _i12;
import 'package:kiddora/features/onboarding/presentation/pages/kid_profile_setup_screen.dart'
    as _i7;
import 'package:kiddora/features/onboarding/presentation/pages/onboarding_screen.dart'
    as _i9;
import 'package:kiddora/features/splash/presentation/pages/splash_screen.dart'
    as _i11;

/// generated route for
/// [_i1.AllCoursesGridScreen]
class AllCoursesGridRoute extends _i13.PageRouteInfo<void> {
  const AllCoursesGridRoute({List<_i13.PageRouteInfo>? children})
    : super(AllCoursesGridRoute.name, initialChildren: children);

  static const String name = 'AllCoursesGridRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i1.AllCoursesGridScreen();
    },
  );
}

/// generated route for
/// [_i2.CourseCurriculumScreen]
class CourseCurriculumRoute
    extends _i13.PageRouteInfo<CourseCurriculumRouteArgs> {
  CourseCurriculumRoute({
    _i14.Key? key,
    required String courseId,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         CourseCurriculumRoute.name,
         args: CourseCurriculumRouteArgs(key: key, courseId: courseId),
         initialChildren: children,
       );

  static const String name = 'CourseCurriculumRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CourseCurriculumRouteArgs>();
      return _i2.CourseCurriculumScreen(key: args.key, courseId: args.courseId);
    },
  );
}

class CourseCurriculumRouteArgs {
  const CourseCurriculumRouteArgs({this.key, required this.courseId});

  final _i14.Key? key;

  final String courseId;

  @override
  String toString() {
    return 'CourseCurriculumRouteArgs{key: $key, courseId: $courseId}';
  }
}

/// generated route for
/// [_i3.CourseDetailScreen]
class CourseDetailRoute extends _i13.PageRouteInfo<CourseDetailRouteArgs> {
  CourseDetailRoute({
    _i14.Key? key,
    required String courseId,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         CourseDetailRoute.name,
         args: CourseDetailRouteArgs(key: key, courseId: courseId),
         initialChildren: children,
       );

  static const String name = 'CourseDetailRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CourseDetailRouteArgs>();
      return _i3.CourseDetailScreen(key: args.key, courseId: args.courseId);
    },
  );
}

class CourseDetailRouteArgs {
  const CourseDetailRouteArgs({this.key, required this.courseId});

  final _i14.Key? key;

  final String courseId;

  @override
  String toString() {
    return 'CourseDetailRouteArgs{key: $key, courseId: $courseId}';
  }
}

/// generated route for
/// [_i4.CourseFilterScreen]
class CourseFilterRoute extends _i13.PageRouteInfo<void> {
  const CourseFilterRoute({List<_i13.PageRouteInfo>? children})
    : super(CourseFilterRoute.name, initialChildren: children);

  static const String name = 'CourseFilterRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i4.CourseFilterScreen();
    },
  );
}

/// generated route for
/// [_i5.CourseSearchScreen]
class CourseSearchRoute extends _i13.PageRouteInfo<void> {
  const CourseSearchRoute({List<_i13.PageRouteInfo>? children})
    : super(CourseSearchRoute.name, initialChildren: children);

  static const String name = 'CourseSearchRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i5.CourseSearchScreen();
    },
  );
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomeScreen();
    },
  );
}

/// generated route for
/// [_i7.KidProfileSetupScreen]
class KidProfileSetupRoute extends _i13.PageRouteInfo<void> {
  const KidProfileSetupRoute({List<_i13.PageRouteInfo>? children})
    : super(KidProfileSetupRoute.name, initialChildren: children);

  static const String name = 'KidProfileSetupRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i7.KidProfileSetupScreen();
    },
  );
}

/// generated route for
/// [_i8.LoginScreen]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute({List<_i13.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i8.LoginScreen();
    },
  );
}

/// generated route for
/// [_i9.OnboardingScreen]
class OnboardingRoute extends _i13.PageRouteInfo<OnboardingRouteArgs> {
  OnboardingRoute({
    _i14.Key? key,
    int initialPage = 0,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         OnboardingRoute.name,
         args: OnboardingRouteArgs(key: key, initialPage: initialPage),
         initialChildren: children,
       );

  static const String name = 'OnboardingRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnboardingRouteArgs>(
        orElse: () => const OnboardingRouteArgs(),
      );
      return _i9.OnboardingScreen(key: args.key, initialPage: args.initialPage);
    },
  );
}

class OnboardingRouteArgs {
  const OnboardingRouteArgs({this.key, this.initialPage = 0});

  final _i14.Key? key;

  final int initialPage;

  @override
  String toString() {
    return 'OnboardingRouteArgs{key: $key, initialPage: $initialPage}';
  }
}

/// generated route for
/// [_i10.RegisterScreen]
class RegisterRoute extends _i13.PageRouteInfo<void> {
  const RegisterRoute({List<_i13.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i10.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i11.SplashScreen]
class SplashRoute extends _i13.PageRouteInfo<void> {
  const SplashRoute({List<_i13.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i11.SplashScreen();
    },
  );
}

/// generated route for
/// [_i12.TodayLearningGoalScreen]
class TodayLearningGoalRoute extends _i13.PageRouteInfo<void> {
  const TodayLearningGoalRoute({List<_i13.PageRouteInfo>? children})
    : super(TodayLearningGoalRoute.name, initialChildren: children);

  static const String name = 'TodayLearningGoalRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i12.TodayLearningGoalScreen();
    },
  );
}

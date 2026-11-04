// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/material.dart' as _i17;
import 'package:kiddora/features/auth/presentation/login_screen.dart' as _i11;
import 'package:kiddora/features/auth/presentation/register_screen.dart'
    as _i13;
import 'package:kiddora/features/exploration/presentation/all_courses_grid_screen.dart'
    as _i1;
import 'package:kiddora/features/exploration/presentation/course_curriculum_screen.dart'
    as _i3;
import 'package:kiddora/features/exploration/presentation/course_detail_screen.dart'
    as _i4;
import 'package:kiddora/features/exploration/presentation/course_filter_sheet.dart'
    as _i5;
import 'package:kiddora/features/exploration/presentation/course_search_screen.dart'
    as _i7;
import 'package:kiddora/features/exploration/presentation/pages/course_completed_celebration_screen.dart'
    as _i2;
import 'package:kiddora/features/exploration/presentation/pages/course_progress_tracker_screen.dart'
    as _i6;
import 'package:kiddora/features/exploration/presentation/pages/lesson_player_screen.dart'
    as _i10;
import 'package:kiddora/features/home/presentation/home_screen.dart' as _i8;
import 'package:kiddora/features/home/presentation/today_learning_goal_screen.dart'
    as _i15;
import 'package:kiddora/features/onboarding/presentation/pages/kid_profile_setup_screen.dart'
    as _i9;
import 'package:kiddora/features/onboarding/presentation/pages/onboarding_screen.dart'
    as _i12;
import 'package:kiddora/features/splash/presentation/pages/splash_screen.dart'
    as _i14;

/// generated route for
/// [_i1.AllCoursesGridScreen]
class AllCoursesGridRoute extends _i16.PageRouteInfo<void> {
  const AllCoursesGridRoute({List<_i16.PageRouteInfo>? children})
    : super(AllCoursesGridRoute.name, initialChildren: children);

  static const String name = 'AllCoursesGridRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i1.AllCoursesGridScreen();
    },
  );
}

/// generated route for
/// [_i2.CourseCompletedCelebrationScreen]
class CourseCompletedCelebrationRoute
    extends _i16.PageRouteInfo<CourseCompletedCelebrationRouteArgs> {
  CourseCompletedCelebrationRoute({
    _i17.Key? key,
    required String courseId,
    String? courseTitle,
    int starsEarned = 50,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         CourseCompletedCelebrationRoute.name,
         args: CourseCompletedCelebrationRouteArgs(
           key: key,
           courseId: courseId,
           courseTitle: courseTitle,
           starsEarned: starsEarned,
         ),
         initialChildren: children,
       );

  static const String name = 'CourseCompletedCelebrationRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CourseCompletedCelebrationRouteArgs>();
      return _i2.CourseCompletedCelebrationScreen(
        key: args.key,
        courseId: args.courseId,
        courseTitle: args.courseTitle,
        starsEarned: args.starsEarned,
      );
    },
  );
}

class CourseCompletedCelebrationRouteArgs {
  const CourseCompletedCelebrationRouteArgs({
    this.key,
    required this.courseId,
    this.courseTitle,
    this.starsEarned = 50,
  });

  final _i17.Key? key;

  final String courseId;

  final String? courseTitle;

  final int starsEarned;

  @override
  String toString() {
    return 'CourseCompletedCelebrationRouteArgs{key: $key, courseId: $courseId, courseTitle: $courseTitle, starsEarned: $starsEarned}';
  }
}

/// generated route for
/// [_i3.CourseCurriculumScreen]
class CourseCurriculumRoute
    extends _i16.PageRouteInfo<CourseCurriculumRouteArgs> {
  CourseCurriculumRoute({
    _i17.Key? key,
    required String courseId,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         CourseCurriculumRoute.name,
         args: CourseCurriculumRouteArgs(key: key, courseId: courseId),
         initialChildren: children,
       );

  static const String name = 'CourseCurriculumRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CourseCurriculumRouteArgs>();
      return _i3.CourseCurriculumScreen(key: args.key, courseId: args.courseId);
    },
  );
}

class CourseCurriculumRouteArgs {
  const CourseCurriculumRouteArgs({this.key, required this.courseId});

  final _i17.Key? key;

  final String courseId;

  @override
  String toString() {
    return 'CourseCurriculumRouteArgs{key: $key, courseId: $courseId}';
  }
}

/// generated route for
/// [_i4.CourseDetailScreen]
class CourseDetailRoute extends _i16.PageRouteInfo<CourseDetailRouteArgs> {
  CourseDetailRoute({
    _i17.Key? key,
    required String courseId,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         CourseDetailRoute.name,
         args: CourseDetailRouteArgs(key: key, courseId: courseId),
         initialChildren: children,
       );

  static const String name = 'CourseDetailRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CourseDetailRouteArgs>();
      return _i4.CourseDetailScreen(key: args.key, courseId: args.courseId);
    },
  );
}

class CourseDetailRouteArgs {
  const CourseDetailRouteArgs({this.key, required this.courseId});

  final _i17.Key? key;

  final String courseId;

  @override
  String toString() {
    return 'CourseDetailRouteArgs{key: $key, courseId: $courseId}';
  }
}

/// generated route for
/// [_i5.CourseFilterScreen]
class CourseFilterRoute extends _i16.PageRouteInfo<void> {
  const CourseFilterRoute({List<_i16.PageRouteInfo>? children})
    : super(CourseFilterRoute.name, initialChildren: children);

  static const String name = 'CourseFilterRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i5.CourseFilterScreen();
    },
  );
}

/// generated route for
/// [_i6.CourseProgressTrackerScreen]
class CourseProgressTrackerRoute
    extends _i16.PageRouteInfo<CourseProgressTrackerRouteArgs> {
  CourseProgressTrackerRoute({
    _i17.Key? key,
    required String courseId,
    String? courseTitle,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         CourseProgressTrackerRoute.name,
         args: CourseProgressTrackerRouteArgs(
           key: key,
           courseId: courseId,
           courseTitle: courseTitle,
         ),
         initialChildren: children,
       );

  static const String name = 'CourseProgressTrackerRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CourseProgressTrackerRouteArgs>();
      return _i6.CourseProgressTrackerScreen(
        key: args.key,
        courseId: args.courseId,
        courseTitle: args.courseTitle,
      );
    },
  );
}

class CourseProgressTrackerRouteArgs {
  const CourseProgressTrackerRouteArgs({
    this.key,
    required this.courseId,
    this.courseTitle,
  });

  final _i17.Key? key;

  final String courseId;

  final String? courseTitle;

  @override
  String toString() {
    return 'CourseProgressTrackerRouteArgs{key: $key, courseId: $courseId, courseTitle: $courseTitle}';
  }
}

/// generated route for
/// [_i7.CourseSearchScreen]
class CourseSearchRoute extends _i16.PageRouteInfo<void> {
  const CourseSearchRoute({List<_i16.PageRouteInfo>? children})
    : super(CourseSearchRoute.name, initialChildren: children);

  static const String name = 'CourseSearchRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i7.CourseSearchScreen();
    },
  );
}

/// generated route for
/// [_i8.HomeScreen]
class HomeRoute extends _i16.PageRouteInfo<void> {
  const HomeRoute({List<_i16.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i8.HomeScreen();
    },
  );
}

/// generated route for
/// [_i9.KidProfileSetupScreen]
class KidProfileSetupRoute extends _i16.PageRouteInfo<void> {
  const KidProfileSetupRoute({List<_i16.PageRouteInfo>? children})
    : super(KidProfileSetupRoute.name, initialChildren: children);

  static const String name = 'KidProfileSetupRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i9.KidProfileSetupScreen();
    },
  );
}

/// generated route for
/// [_i10.LessonPlayerScreen]
class LessonPlayerRoute extends _i16.PageRouteInfo<LessonPlayerRouteArgs> {
  LessonPlayerRoute({
    _i17.Key? key,
    required String lessonId,
    String? courseTitle,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         LessonPlayerRoute.name,
         args: LessonPlayerRouteArgs(
           key: key,
           lessonId: lessonId,
           courseTitle: courseTitle,
         ),
         initialChildren: children,
       );

  static const String name = 'LessonPlayerRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LessonPlayerRouteArgs>();
      return _i10.LessonPlayerScreen(
        key: args.key,
        lessonId: args.lessonId,
        courseTitle: args.courseTitle,
      );
    },
  );
}

class LessonPlayerRouteArgs {
  const LessonPlayerRouteArgs({
    this.key,
    required this.lessonId,
    this.courseTitle,
  });

  final _i17.Key? key;

  final String lessonId;

  final String? courseTitle;

  @override
  String toString() {
    return 'LessonPlayerRouteArgs{key: $key, lessonId: $lessonId, courseTitle: $courseTitle}';
  }
}

/// generated route for
/// [_i11.LoginScreen]
class LoginRoute extends _i16.PageRouteInfo<void> {
  const LoginRoute({List<_i16.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i11.LoginScreen();
    },
  );
}

/// generated route for
/// [_i12.OnboardingScreen]
class OnboardingRoute extends _i16.PageRouteInfo<OnboardingRouteArgs> {
  OnboardingRoute({
    _i17.Key? key,
    int initialPage = 0,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         OnboardingRoute.name,
         args: OnboardingRouteArgs(key: key, initialPage: initialPage),
         initialChildren: children,
       );

  static const String name = 'OnboardingRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnboardingRouteArgs>(
        orElse: () => const OnboardingRouteArgs(),
      );
      return _i12.OnboardingScreen(
        key: args.key,
        initialPage: args.initialPage,
      );
    },
  );
}

class OnboardingRouteArgs {
  const OnboardingRouteArgs({this.key, this.initialPage = 0});

  final _i17.Key? key;

  final int initialPage;

  @override
  String toString() {
    return 'OnboardingRouteArgs{key: $key, initialPage: $initialPage}';
  }
}

/// generated route for
/// [_i13.RegisterScreen]
class RegisterRoute extends _i16.PageRouteInfo<void> {
  const RegisterRoute({List<_i16.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i13.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i14.SplashScreen]
class SplashRoute extends _i16.PageRouteInfo<void> {
  const SplashRoute({List<_i16.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i14.SplashScreen();
    },
  );
}

/// generated route for
/// [_i15.TodayLearningGoalScreen]
class TodayLearningGoalRoute extends _i16.PageRouteInfo<void> {
  const TodayLearningGoalRoute({List<_i16.PageRouteInfo>? children})
    : super(TodayLearningGoalRoute.name, initialChildren: children);

  static const String name = 'TodayLearningGoalRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i15.TodayLearningGoalScreen();
    },
  );
}

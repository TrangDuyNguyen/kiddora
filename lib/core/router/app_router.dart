import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  // Splash is always the entry point — it decides where to go.
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: KidProfileSetupRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: TodayLearningGoalRoute.page),
        AutoRoute(page: CourseSearchRoute.page),
        AutoRoute(page: CourseFilterRoute.page),
        AutoRoute(page: AllCoursesGridRoute.page),
        AutoRoute(page: CourseDetailRoute.page),
        AutoRoute(page: CourseCurriculumRoute.page),
        AutoRoute(page: LessonPlayerRoute.page),
        AutoRoute(page: CourseProgressTrackerRoute.page),
        AutoRoute(page: CourseCompletedCelebrationRoute.page),
        AutoRoute(page: MiniGamePlaygroundRoute.page),
      ];
}

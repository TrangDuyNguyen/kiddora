import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({this.hasCompletedOnboarding = false});

  final bool hasCompletedOnboarding;

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: OnboardingRoute.page,
          initial: !hasCompletedOnboarding,
        ),
        AutoRoute(
          page: KidProfileSetupRoute.page,
        ),
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(
          page: HomeRoute.page,
          initial: hasCompletedOnboarding,
        ),
        AutoRoute(
          page: TodayLearningGoalRoute.page,
        ),
      ];
}

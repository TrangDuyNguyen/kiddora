import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/models/home_dashboard_summary.dart';

final homeDashboardControllerProvider =
    AsyncNotifierProvider<HomeDashboardController, HomeDashboardSummary>(
  HomeDashboardController.new,
);

class HomeDashboardController extends AsyncNotifier<HomeDashboardSummary> {
  @override
  Future<HomeDashboardSummary> build() async {
    final repo = ref.watch(homeRepositoryProvider);
    return repo.getHomeSummary();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(homeRepositoryProvider);
      return repo.getHomeSummary();
    });
  }
}


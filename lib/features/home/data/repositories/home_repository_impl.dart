import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/models/home_dashboard_summary.dart';
import '../../domain/repositories/home_repository.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return HomeRepositoryImpl(apiClient: apiClient);
});

class HomeRepositoryImpl implements HomeRepository {
  final ApiClient apiClient;
  HomeDashboardSummary? _cachedSummary;

  HomeRepositoryImpl({required this.apiClient});

  @override
  Future<HomeDashboardSummary> getHomeSummary() async {
    try {
      final response = await apiClient.dio.get('/api/v1/home/summary');
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        final summary = HomeDashboardSummary.fromJson(data);
        _cachedSummary = summary;
        return summary;
      }
    } catch (_) {
      // Offline fallback: return cached summary if available or safe defaults
      if (_cachedSummary != null) {
        return _cachedSummary!;
      }
    }
    return _cachedSummary ?? const HomeDashboardSummary();
  }
}


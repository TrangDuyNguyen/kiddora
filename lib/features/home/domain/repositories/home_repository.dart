import '../models/home_dashboard_summary.dart';

abstract class HomeRepository {
  Future<HomeDashboardSummary> getHomeSummary();
}


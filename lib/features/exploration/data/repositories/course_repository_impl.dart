import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/models/course.dart';
import '../../domain/models/course_filter.dart';
import '../../domain/repositories/i_course_repository.dart';
import '../datasources/mock_course_datasource.dart';

class CourseRepositoryImpl implements ICourseRepository {
  final ApiClient apiClient;

  CourseRepositoryImpl({required this.apiClient});

  @override
  Future<List<Course>> getCourses({CourseFilter? filter}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (filter != null) {
        if (filter.category != 'all' && filter.category.isNotEmpty) {
          queryParams['category'] = filter.category;
        }
        if (filter.ageRange != 'all' && filter.ageRange.isNotEmpty) {
          if (filter.ageRange == '7-8') {
            queryParams['min_age'] = 7;
            queryParams['max_age'] = 8;
          } else if (filter.ageRange == '9-10') {
            queryParams['min_age'] = 9;
            queryParams['max_age'] = 10;
          } else if (filter.ageRange == '11-12') {
            queryParams['min_age'] = 11;
            queryParams['max_age'] = 12;
          }
        }
        if (filter.level != 'all' && filter.level.isNotEmpty) {
          queryParams['level'] = filter.level;
        }
        if (filter.duration != 'all' && filter.duration.isNotEmpty) {
          queryParams['duration'] = filter.duration;
        }
        if (filter.searchQuery.trim().isNotEmpty) {
          queryParams['search'] = filter.searchQuery.trim();
        }
      }

      final res = await apiClient.dio.get(
        '/api/v1/courses',
        queryParameters: queryParams,
      );

      if (res.statusCode == 200 && res.data is List) {
        final list = (res.data as List)
            .map((e) => Course.fromMap(e as Map<String, dynamic>))
            .toList();
        if (list.isNotEmpty) {
          return list;
        }
      }
    } catch (_) {
      // Fallback seamlessly to mock seed data if server is unreachable
    }

    final mock = MockCourseDatasource.getBenchmarkCourses();
    if (filter != null) {
      return mock.where((c) => filter.matches(c)).toList();
    }
    return mock;
  }

  @override
  Future<Course> getCourseDetail(String courseId) async {
    try {
      final res = await apiClient.dio.get('/api/v1/courses/$courseId');
      if (res.statusCode == 200 && res.data is Map<String, dynamic>) {
        return Course.fromMap(res.data as Map<String, dynamic>);
      }
    } catch (_) {
      // Fallback to mock
    }

    final mock = MockCourseDatasource.getBenchmarkCourses();
    return mock.firstWhere(
      (c) => c.id == courseId,
      orElse: () => mock.first,
    );
  }
}

class MockCourseRepository implements ICourseRepository {
  final List<Course> _courses;

  MockCourseRepository([List<Course>? initial])
      : _courses = initial ?? MockCourseDatasource.getBenchmarkCourses();

  @override
  Future<List<Course>> getCourses({CourseFilter? filter}) async {
    if (filter == null || filter.isDefault) {
      return List.unmodifiable(_courses);
    }
    return _courses.where((c) => filter.matches(c)).toList();
  }

  @override
  Future<Course> getCourseDetail(String courseId) async {
    return _courses.firstWhere(
      (c) => c.id == courseId,
      orElse: () => _courses.first,
    );
  }
}

final courseRepositoryProvider = Provider<ICourseRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CourseRepositoryImpl(apiClient: apiClient);
});


import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_values.dart';
import '../../data/repositories/course_repository_impl.dart';
import '../../domain/models/course.dart';
import '../../domain/models/course_filter.dart';
import '../../domain/repositories/i_course_repository.dart';

class CourseSearchState {
  final String query;
  final AsyncValue<List<Course>> results;

  const CourseSearchState({
    this.query = '',
    required this.results,
  });

  CourseSearchState copyWith({
    String? query,
    AsyncValue<List<Course>>? results,
  }) {
    return CourseSearchState(
      query: query ?? this.query,
      results: results ?? this.results,
    );
  }
}

class CourseSearchController extends StateNotifier<CourseSearchState> {
  final ICourseRepository _repository;
  Timer? _debounceTimer;

  CourseSearchController(this._repository)
      : super(const CourseSearchState(results: AsyncValue.data([]))) {
    search('');
  }

  void onQueryChanged(String newQuery) {
    state = state.copyWith(query: newQuery);
    _debounceTimer?.cancel();
    _debounceTimer = Timer(AppValues.durationDebounce, () {
      search(newQuery);
    });
  }

  Future<void> search(String query) async {
    state = state.copyWith(results: const AsyncValue.loading());
    try {
      final filter = CourseFilter(searchQuery: query);
      final list = await _repository.getCourses(filter: filter);
      state = state.copyWith(results: AsyncValue.data(list));
    } catch (e, st) {
      state = state.copyWith(results: AsyncValue.error(e, st));
    }
  }

  void clearQuery() {
    _debounceTimer?.cancel();
    state = state.copyWith(query: '');
    search('');
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

final courseSearchControllerProvider =
    StateNotifierProvider<CourseSearchController, CourseSearchState>((ref) {
  final repo = ref.watch(courseRepositoryProvider);
  return CourseSearchController(repo);
});


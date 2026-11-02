import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/course_repository_impl.dart';
import '../../domain/models/course.dart';
import '../../domain/models/course_filter.dart';
import '../../domain/repositories/i_course_repository.dart';

class CoursesState {
  final AsyncValue<List<Course>> courses;
  final CourseFilter filter;
  final Set<String> favoriteIds;

  const CoursesState({
    required this.courses,
    this.filter = const CourseFilter(),
    this.favoriteIds = const {},
  });

  CoursesState copyWith({
    AsyncValue<List<Course>>? courses,
    CourseFilter? filter,
    Set<String>? favoriteIds,
  }) {
    return CoursesState(
      courses: courses ?? this.courses,
      filter: filter ?? this.filter,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }
}

class CoursesController extends StateNotifier<CoursesState> {
  final ICourseRepository _repository;

  CoursesController(this._repository)
      : super(const CoursesState(courses: AsyncValue.loading())) {
    loadCourses();
  }

  Future<void> loadCourses() async {
    state = state.copyWith(courses: const AsyncValue.loading());
    try {
      final list = await _repository.getCourses(filter: state.filter);
      final mapped = list.map((c) {
        return c.copyWith(isFavorite: state.favoriteIds.contains(c.id));
      }).toList();
      state = state.copyWith(courses: AsyncValue.data(mapped));
    } catch (e, st) {
      state = state.copyWith(courses: AsyncValue.error(e, st));
    }
  }

  Future<void> setCategory(String category) async {
    final updated = state.filter.copyWith(category: category);
    state = state.copyWith(filter: updated);
    await loadCourses();
  }

  Future<void> applyFilter(CourseFilter filter) async {
    state = state.copyWith(filter: filter);
    await loadCourses();
  }

  Future<void> resetFilter() async {
    state = state.copyWith(filter: const CourseFilter());
    await loadCourses();
  }

  void toggleFavorite(String courseId) {
    final updated = Set<String>.from(state.favoriteIds);
    if (updated.contains(courseId)) {
      updated.remove(courseId);
    } else {
      updated.add(courseId);
    }

    final currentData = state.courses.valueOrNull;
    if (currentData != null) {
      final updatedList = currentData.map((c) {
        if (c.id == courseId) {
          return c.copyWith(isFavorite: updated.contains(courseId));
        }
        return c;
      }).toList();
      state = state.copyWith(
        courses: AsyncValue.data(updatedList),
        favoriteIds: updated,
      );
    } else {
      state = state.copyWith(favoriteIds: updated);
    }
  }
}

final coursesControllerProvider =
    StateNotifierProvider<CoursesController, CoursesState>((ref) {
  final repo = ref.watch(courseRepositoryProvider);
  return CoursesController(repo);
});


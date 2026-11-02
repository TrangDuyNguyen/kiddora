import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/course_repository_impl.dart';
import '../../domain/models/course.dart';
import '../../domain/repositories/i_course_repository.dart';

class CourseDetailState {
  final AsyncValue<Course> course;
  final int activeTabIndex;

  const CourseDetailState({
    required this.course,
    this.activeTabIndex = 0,
  });

  CourseDetailState copyWith({
    AsyncValue<Course>? course,
    int? activeTabIndex,
  }) {
    return CourseDetailState(
      course: course ?? this.course,
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
    );
  }
}

class CourseDetailController extends StateNotifier<CourseDetailState> {
  final ICourseRepository _repository;
  final String courseId;

  CourseDetailController(this._repository, this.courseId)
      : super(const CourseDetailState(course: AsyncValue.loading())) {
    loadCourse();
  }

  Future<void> loadCourse() async {
    state = state.copyWith(course: const AsyncValue.loading());
    try {
      final c = await _repository.getCourseDetail(courseId);
      state = state.copyWith(course: AsyncValue.data(c));
    } catch (e, st) {
      state = state.copyWith(course: AsyncValue.error(e, st));
    }
  }

  void setTabIndex(int index) {
    if (state.activeTabIndex != index) {
      state = state.copyWith(activeTabIndex: index);
    }
  }
}

final courseDetailControllerProvider = StateNotifierProvider.family<
    CourseDetailController, CourseDetailState, String>((ref, courseId) {
  final repo = ref.watch(courseRepositoryProvider);
  return CourseDetailController(repo, courseId);
});


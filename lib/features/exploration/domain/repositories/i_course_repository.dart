import '../models/course.dart';
import '../models/course_filter.dart';

abstract class ICourseRepository {
  Future<List<Course>> getCourses({CourseFilter? filter});
  Future<Course> getCourseDetail(String courseId);
}


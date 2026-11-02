import 'course.dart';

/// Immutable filter criteria for courses exploration & search
class CourseFilter {
  final String category;
  final String ageRange;
  final String level;
  final String duration;
  final String searchQuery;

  const CourseFilter({
    this.category = 'all',
    this.ageRange = 'all',
    this.level = 'all',
    this.duration = 'all',
    this.searchQuery = '',
  });

  bool get isDefault =>
      (category == 'all' || category.isEmpty) &&
      (ageRange == 'all' || ageRange.isEmpty) &&
      (level == 'all' || level.isEmpty) &&
      (duration == 'all' || duration.isEmpty) &&
      searchQuery.trim().isEmpty;

  int get activeFiltersCount {
    int count = 0;
    if (category != 'all' && category.isNotEmpty) count++;
    if (ageRange != 'all' && ageRange.isNotEmpty) count++;
    if (level != 'all' && level.isNotEmpty) count++;
    if (duration != 'all' && duration.isNotEmpty) count++;
    return count;
  }

  CourseFilter copyWith({
    String? category,
    String? ageRange,
    String? level,
    String? duration,
    String? searchQuery,
  }) {
    return CourseFilter(
      category: category ?? this.category,
      ageRange: ageRange ?? this.ageRange,
      level: level ?? this.level,
      duration: duration ?? this.duration,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  bool matches(Course course) {
    if (category != 'all' && category.isNotEmpty) {
      if (course.category.toLowerCase() != category.toLowerCase()) {
        return false;
      }
    }

    if (ageRange != 'all' && ageRange.isNotEmpty) {
      if (ageRange == '7-8' && (course.minAge > 8 || course.maxAge < 7)) {
        return false;
      } else if (ageRange == '9-10' && (course.minAge > 10 || course.maxAge < 9)) {
        return false;
      } else if (ageRange == '11-12' && (course.minAge > 12 || course.maxAge < 11)) {
        return false;
      }
    }

    if (level != 'all' && level.isNotEmpty) {
      if (course.level.toLowerCase() != level.toLowerCase()) {
        return false;
      }
    }

    if (duration != 'all' && duration.isNotEmpty) {
      final total = course.totalLessons;
      if (duration == 'short' && (total < 1 || total > 3)) {
        return false;
      } else if (duration == 'medium' && (total < 4 || total > 6)) {
        return false;
      } else if (duration == 'long' && total < 7) {
        return false;
      }
    }

    if (searchQuery.trim().isNotEmpty) {
      final query = searchQuery.toLowerCase().trim();
      final inTitle = course.title.toLowerCase().contains(query);
      final inDesc = course.description.toLowerCase().contains(query);
      final inCategory = course.category.toLowerCase().contains(query);
      if (!inTitle && !inDesc && !inCategory) {
        return false;
      }
    }

    return true;
  }
}


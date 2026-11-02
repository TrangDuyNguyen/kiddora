import 'lesson.dart';

/// Domain entity representing a full Course in Kiddora
class Course {
  final String id;
  final String title;
  final String? subtitle;
  final String description;
  final String category;
  final int minAge;
  final int maxAge;
  final String level;
  final int totalLessons;
  final double rating;
  final int reviewCount;
  final String thumbnailUrl;
  final bool isFeatured;
  final bool isFavorite;
  final List<Lesson> lessons;

  const Course({
    required this.id,
    required this.title,
    this.subtitle,
    required this.description,
    required this.category,
    required this.minAge,
    required this.maxAge,
    this.level = 'beginner',
    required this.totalLessons,
    required this.rating,
    required this.reviewCount,
    required this.thumbnailUrl,
    this.isFeatured = false,
    this.isFavorite = false,
    this.lessons = const [],
  });

  Course copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? description,
    String? category,
    int? minAge,
    int? maxAge,
    String? level,
    int? totalLessons,
    double? rating,
    int? reviewCount,
    String? thumbnailUrl,
    bool? isFeatured,
    bool? isFavorite,
    List<Lesson>? lessons,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      category: category ?? this.category,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      level: level ?? this.level,
      totalLessons: totalLessons ?? this.totalLessons,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      isFeatured: isFeatured ?? this.isFeatured,
      isFavorite: isFavorite ?? this.isFavorite,
      lessons: lessons ?? this.lessons,
    );
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    final lessonsList = (map['lessons'] as List<dynamic>?)
            ?.map((e) => Lesson.fromMap(e as Map<String, dynamic>))
            .toList() ??
        const [];

    return Course(
      id: map['id']?.toString() ?? '',
      title: map['title'] as String? ?? '',
      subtitle: map['subtitle'] as String?,
      description: map['description'] as String? ?? '',
      category: map['category'] as String? ?? 'science',
      minAge: (map['min_age'] as num?)?.toInt() ?? 6,
      maxAge: (map['max_age'] as num?)?.toInt() ?? 12,
      level: map['level'] as String? ?? 'beginner',
      totalLessons: (map['total_lessons'] as num?)?.toInt() ?? lessonsList.length,
      rating: (map['rating'] as num?)?.toDouble() ?? 5.0,
      reviewCount: (map['review_count'] as num?)?.toInt() ?? 0,
      thumbnailUrl: map['thumbnail_url'] as String? ?? '',
      isFeatured: map['is_featured'] as bool? ?? false,
      isFavorite: map['is_favorite'] as bool? ?? false,
      lessons: lessonsList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'category': category,
      'min_age': minAge,
      'max_age': maxAge,
      'level': level,
      'total_lessons': totalLessons,
      'rating': rating,
      'review_count': reviewCount,
      'thumbnail_url': thumbnailUrl,
      'is_featured': isFeatured,
      'is_favorite': isFavorite,
      'lessons': lessons.map((e) => e.toMap()).toList(),
    };
  }
}


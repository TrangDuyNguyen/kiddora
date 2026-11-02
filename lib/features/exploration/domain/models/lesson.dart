/// Domain model for an individual lesson within a course
class Lesson {
  final String id;
  final int orderIndex;
  final String title;
  final int durationMins;
  final String thumbnailUrl;
  final String? videoUrl;
  final bool isUnlocked;
  final bool isCompleted;

  const Lesson({
    required this.id,
    required this.orderIndex,
    required this.title,
    required this.durationMins,
    required this.thumbnailUrl,
    this.videoUrl,
    this.isUnlocked = false,
    this.isCompleted = false,
  });

  Lesson copyWith({
    String? id,
    int? orderIndex,
    String? title,
    int? durationMins,
    String? thumbnailUrl,
    String? videoUrl,
    bool? isUnlocked,
    bool? isCompleted,
  }) {
    return Lesson(
      id: id ?? this.id,
      orderIndex: orderIndex ?? this.orderIndex,
      title: title ?? this.title,
      durationMins: durationMins ?? this.durationMins,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id']?.toString() ?? '',
      orderIndex: (map['order_index'] as num?)?.toInt() ?? 1,
      title: map['title'] as String? ?? '',
      durationMins: (map['duration_mins'] as num?)?.toInt() ?? 10,
      thumbnailUrl: map['thumbnail_url'] as String? ?? '',
      videoUrl: map['video_url'] as String?,
      isUnlocked: map['is_unlocked'] as bool? ?? false,
      isCompleted: map['is_completed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_index': orderIndex,
      'title': title,
      'duration_mins': durationMins,
      'thumbnail_url': thumbnailUrl,
      'video_url': videoUrl,
      'is_unlocked': isUnlocked,
      'is_completed': isCompleted,
    };
  }
}


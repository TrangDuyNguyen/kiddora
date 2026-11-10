class HomeKidProfile {
  final String nickname;
  final String mascotId;
  final String avatarAsset;
  final int starPoints;
  final int streakDays;

  const HomeKidProfile({
    this.nickname = 'Chay',
    this.mascotId = 'zodiac_dragon',
    this.avatarAsset = 'assets/images/zodiac_dragon.png',
    this.starPoints = 120,
    this.streakDays = 5,
  });

  factory HomeKidProfile.fromJson(Map<String, dynamic> json) {
    return HomeKidProfile(
      nickname: json['nickname'] as String? ?? 'Chay',
      mascotId: json['mascot_id'] as String? ?? 'zodiac_dragon',
      avatarAsset: json['avatar_asset'] as String? ?? 'assets/images/zodiac_dragon.png',
      starPoints: json['star_points'] as int? ?? 120,
      streakDays: json['streak_days'] as int? ?? 5,
    );
  }

  Map<String, dynamic> toJson() => {
    'nickname': nickname,
    'mascot_id': mascotId,
    'avatar_asset': avatarAsset,
    'star_points': starPoints,
    'streak_days': streakDays,
  };
}

class HomeStats {
  final int activeCoursesCount;
  final int upcomingSessionsCount;
  final int earnedBadgesCount;
  final int progressPercentage;

  const HomeStats({
    this.activeCoursesCount = 3,
    this.upcomingSessionsCount = 1,
    this.earnedBadgesCount = 5,
    this.progressPercentage = 60,
  });

  factory HomeStats.fromJson(Map<String, dynamic> json) {
    return HomeStats(
      activeCoursesCount: json['active_courses_count'] as int? ?? 3,
      upcomingSessionsCount: json['upcoming_sessions_count'] as int? ?? 1,
      earnedBadgesCount: json['earned_badges_count'] as int? ?? 5,
      progressPercentage: json['progress_percentage'] as int? ?? 60,
    );
  }

  Map<String, dynamic> toJson() => {
    'active_courses_count': activeCoursesCount,
    'upcoming_sessions_count': upcomingSessionsCount,
    'earned_badges_count': earnedBadgesCount,
    'progress_percentage': progressPercentage,
  };
}

class HomeContinueLearning {
  final String courseId;
  final String courseTitle;
  final String subjectName;
  final String thumbnailAsset;
  final String nextLessonId;
  final String nextLessonTitle;
  final int completedLessons;
  final int totalLessons;
  final double progressPercentage;

  const HomeContinueLearning({
    this.courseId = 'c-science-01',
    this.courseTitle = 'Amazing Animals',
    this.subjectName = 'Science',
    this.thumbnailAsset = 'assets/images/course_dino.png',
    this.nextLessonId = 'les-animal-01',
    this.nextLessonTitle = 'Meet the Animals',
    this.completedLessons = 3,
    this.totalLessons = 5,
    this.progressPercentage = 0.6,
  });

  factory HomeContinueLearning.fromJson(Map<String, dynamic> json) {
    return HomeContinueLearning(
      courseId: json['course_id'] as String? ?? 'c-science-01',
      courseTitle: json['course_title'] as String? ?? 'Amazing Animals',
      subjectName: json['subject_name'] as String? ?? 'Science',
      thumbnailAsset: json['thumbnail_asset'] as String? ?? 'assets/images/course_dino.png',
      nextLessonId: json['next_lesson_id'] as String? ?? 'les-animal-01',
      nextLessonTitle: json['next_lesson_title'] as String? ?? 'Meet the Animals',
      completedLessons: json['completed_lessons'] as int? ?? 3,
      totalLessons: json['total_lessons'] as int? ?? 5,
      progressPercentage: (json['progress_percentage'] as num?)?.toDouble() ?? 0.6,
    );
  }

  Map<String, dynamic> toJson() => {
    'course_id': courseId,
    'course_title': courseTitle,
    'subject_name': subjectName,
    'thumbnail_asset': thumbnailAsset,
    'next_lesson_id': nextLessonId,
    'next_lesson_title': nextLessonTitle,
    'completed_lessons': completedLessons,
    'total_lessons': totalLessons,
    'progress_percentage': progressPercentage,
  };
}

class HomeUpcomingSession {
  final String sessionId;
  final String title;
  final String coachName;
  final String coachAvatar;
  final String scheduledTime;
  final String status;

  const HomeUpcomingSession({
    this.sessionId = 'sess-live-101',
    this.title = 'Math Fun with Numbers',
    this.coachName = 'Coach Sarah',
    this.coachAvatar = 'assets/images/avatar_coach_sarah.png',
    this.scheduledTime = 'Today, 4:00 PM',
    this.status = 'upcoming',
  });

  factory HomeUpcomingSession.fromJson(Map<String, dynamic> json) {
    return HomeUpcomingSession(
      sessionId: json['session_id'] as String? ?? 'sess-live-101',
      title: json['title'] as String? ?? 'Math Fun with Numbers',
      coachName: json['coach_name'] as String? ?? 'Coach Sarah',
      coachAvatar: json['coach_avatar'] as String? ?? 'assets/images/avatar_coach_sarah.png',
      scheduledTime: json['scheduled_time'] as String? ?? 'Today, 4:00 PM',
      status: json['status'] as String? ?? 'upcoming',
    );
  }

  Map<String, dynamic> toJson() => {
    'session_id': sessionId,
    'title': title,
    'coach_name': coachName,
    'coach_avatar': coachAvatar,
    'scheduled_time': scheduledTime,
    'status': status,
  };
}

class HomeDashboardSummary {
  final HomeKidProfile kidProfile;
  final HomeStats stats;
  final HomeContinueLearning continueLearning;
  final HomeUpcomingSession upcomingSession;
  final int unreadNotificationsCount;

  const HomeDashboardSummary({
    this.kidProfile = const HomeKidProfile(),
    this.stats = const HomeStats(),
    this.continueLearning = const HomeContinueLearning(),
    this.upcomingSession = const HomeUpcomingSession(),
    this.unreadNotificationsCount = 3,
  });

  factory HomeDashboardSummary.fromJson(Map<String, dynamic> json) {
    return HomeDashboardSummary(
      kidProfile: json['kid_profile'] != null
          ? HomeKidProfile.fromJson(json['kid_profile'] as Map<String, dynamic>)
          : const HomeKidProfile(),
      stats: json['stats'] != null
          ? HomeStats.fromJson(json['stats'] as Map<String, dynamic>)
          : const HomeStats(),
      continueLearning: json['continue_learning'] != null
          ? HomeContinueLearning.fromJson(json['continue_learning'] as Map<String, dynamic>)
          : const HomeContinueLearning(),
      upcomingSession: json['upcoming_session'] != null
          ? HomeUpcomingSession.fromJson(json['upcoming_session'] as Map<String, dynamic>)
          : const HomeUpcomingSession(),
      unreadNotificationsCount: json['unread_notifications_count'] as int? ?? 3,
    );
  }

  Map<String, dynamic> toJson() => {
    'kid_profile': kidProfile.toJson(),
    'stats': stats.toJson(),
    'continue_learning': continueLearning.toJson(),
    'upcoming_session': upcomingSession.toJson(),
    'unread_notifications_count': unreadNotificationsCount,
  };
}


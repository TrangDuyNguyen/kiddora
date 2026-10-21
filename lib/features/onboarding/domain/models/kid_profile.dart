import 'dart:convert';

/// Domain Entity đại diện cho hồ sơ học tập của bé
class KidProfile {
  KidProfile({
    required this.id,
    required this.nickname,
    required this.age,
    required this.avatarId,
    this.currentStars = 10,
    this.currentStreak = 1,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  final String id;
  final String nickname;
  final int age;
  final String avatarId;
  final int currentStars;
  final int currentStreak;
  final DateTime createdAt;

  KidProfile copyWith({
    String? id,
    String? nickname,
    int? age,
    String? avatarId,
    int? currentStars,
    int? currentStreak,
    DateTime? createdAt,
  }) {
    return KidProfile(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      age: age ?? this.age,
      avatarId: avatarId ?? this.avatarId,
      currentStars: currentStars ?? this.currentStars,
      currentStreak: currentStreak ?? this.currentStreak,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickname': nickname,
      'age': age,
      'avatarId': avatarId,
      'currentStars': currentStars,
      'currentStreak': currentStreak,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory KidProfile.fromMap(Map<String, dynamic> map) {
    return KidProfile(
      id: map['id'] as String? ?? 'kid_01',
      nickname: map['nickname'] as String? ?? 'Bé Yêu',
      age: (map['age'] as num?)?.toInt() ?? 8,
      avatarId: map['avatarId'] as String? ?? 'lion',
      currentStars: (map['currentStars'] as num?)?.toInt() ?? 10,
      currentStreak: (map['currentStreak'] as num?)?.toInt() ?? 1,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory KidProfile.fromJson(String source) =>
      KidProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KidProfile &&
        other.id == id &&
        other.nickname == nickname &&
        other.age == age &&
        other.avatarId == avatarId &&
        other.currentStars == currentStars &&
        other.currentStreak == currentStreak;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nickname.hashCode ^
        age.hashCode ^
        avatarId.hashCode ^
        currentStars.hashCode ^
        currentStreak.hashCode;
  }
}

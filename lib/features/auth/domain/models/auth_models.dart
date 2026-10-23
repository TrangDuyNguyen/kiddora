import 'package:kiddora/features/onboarding/domain/models/kid_profile.dart';


class UserModel {
  final String id;
  final String email;
  final String? fullName;
  final String role;

  const UserModel({
    required this.id,
    required this.email,
    this.fullName,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toString() ?? '',
      email: map['email'] as String? ?? '',
      fullName: map['full_name'] as String?,
      role: map['role'] as String? ?? 'parent',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'role': role,
    };
  }
}

class AuthSession {
  final String accessToken;
  final String refreshToken;
  final UserModel user;
  final KidProfile? kidProfile;

  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    this.kidProfile,
  });

  factory AuthSession.fromMap(Map<String, dynamic> map) {
    return AuthSession(
      accessToken: map['access_token'] as String? ?? '',
      refreshToken: map['refresh_token'] as String? ?? '',
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>? ?? {}),
      kidProfile: map['kid_profile'] != null
          ? KidProfile.fromMap(map['kid_profile'] as Map<String, dynamic>)
          : null,
    );
  }
}

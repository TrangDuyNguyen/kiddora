import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage? _storage;
  final Map<String, String> _memoryFallback;

  static const String _accessTokenKey = 'kiddora_access_token';
  static const String _refreshTokenKey = 'kiddora_refresh_token';
  static const String _guestModeKey = 'kiddora_is_guest';

  TokenStorage([
    FlutterSecureStorage? storage,
    Map<String, String>? memoryFallback,
  ])  : _storage = storage ?? const FlutterSecureStorage(),
        _memoryFallback = memoryFallback ?? {};

  bool get _isTest {
    try {
      return Platform.environment.containsKey('FLUTTER_TEST');
    } catch (_) {
      return false;
    }
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _memoryFallback[_accessTokenKey] = accessToken;
    _memoryFallback[_refreshTokenKey] = refreshToken;
    final storage = _storage;
    if (!_isTest && storage != null) {
      try {
        await storage.write(key: _accessTokenKey, value: accessToken);
        await storage.write(key: _refreshTokenKey, value: refreshToken);
      } catch (_) {}
    }
    await setGuestMode(false);
  }

  Future<String?> getAccessToken() async {
    if (_isTest || _storage == null) {
      return _memoryFallback[_accessTokenKey];
    }
    if (_memoryFallback.containsKey(_accessTokenKey)) {
      return _memoryFallback[_accessTokenKey];
    }
    final storage = _storage;
    if (storage != null) {
      try {
        return await storage.read(key: _accessTokenKey);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  Future<String?> getRefreshToken() async {
    if (_isTest || _storage == null) {
      return _memoryFallback[_refreshTokenKey];
    }
    if (_memoryFallback.containsKey(_refreshTokenKey)) {
      return _memoryFallback[_refreshTokenKey];
    }
    final storage = _storage;
    if (storage != null) {
      try {
        return await storage.read(key: _refreshTokenKey);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  Future<void> clearTokens() async {
    _memoryFallback.remove(_accessTokenKey);
    _memoryFallback.remove(_refreshTokenKey);
    final storage = _storage;
    if (!_isTest && storage != null) {
      try {
        await storage.delete(key: _accessTokenKey);
        await storage.delete(key: _refreshTokenKey);
      } catch (_) {}
    }
  }

  Future<void> setGuestMode(bool isGuest) async {
    _memoryFallback[_guestModeKey] = isGuest.toString();
    final storage = _storage;
    if (!_isTest && storage != null) {
      try {
        await storage.write(key: _guestModeKey, value: isGuest.toString());
      } catch (_) {}
    }
  }

  Future<bool> isGuestMode() async {
    if (_isTest || _storage == null) {
      return _memoryFallback[_guestModeKey] == 'true';
    }
    if (_memoryFallback.containsKey(_guestModeKey)) {
      return _memoryFallback[_guestModeKey] == 'true';
    }
    final storage = _storage;
    if (storage != null) {
      try {
        final val = await storage.read(key: _guestModeKey);
        return val == 'true';
      } catch (_) {
        return false;
      }
    }
    return false;
  }
}

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});

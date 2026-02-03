import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearCache();
  Future<void> cacheToken(String token);
  Future<String?> getCachedToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String _cachedUserKey = 'CACHED_USER';
  static const String _cachedTokenKey = 'CACHED_TOKEN';

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      final userJson = json.encode(user.toJson());
      await sharedPreferences.setString(_cachedUserKey, userJson);
    } catch (e) {
      throw CacheException(
        'Erreur lors de la mise en cache de l\'utilisateur: $e',
      );
    }
  }

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final userJson = sharedPreferences.getString(_cachedUserKey);
      if (userJson != null) {
        return UserModel.fromJson(json.decode(userJson));
      }
      return null;
    } catch (e) {
      throw CacheException(
        'Erreur lors de la récupération de l\'utilisateur: $e',
      );
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await sharedPreferences.remove(_cachedUserKey);
      await sharedPreferences.remove(_cachedTokenKey);
    } catch (e) {
      throw CacheException('Erreur lors de la suppression du cache: $e');
    }
  }

  @override
  Future<void> cacheToken(String token) async {
    try {
      await sharedPreferences.setString(_cachedTokenKey, token);
    } catch (e) {
      throw CacheException('Erreur lors de la mise en cache du token: $e');
    }
  }

  @override
  Future<String?> getCachedToken() async {
    try {
      return sharedPreferences.getString(_cachedTokenKey);
    } catch (e) {
      throw CacheException('Erreur lors de la récupération du token: $e');
    }
  }
}

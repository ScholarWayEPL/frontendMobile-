/// Constantes de l'application
class AppConstants {
  // API
  static const String baseUrl = 'https://api.scholarway.com';
  static const String apiVersion = 'v1';

  // Clés de stockage
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String refreshTokenKey = 'refresh_token';

  // Timeouts (en millisecondes)
  static const int connectionTimeout = 30000; // 30 secondes
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  // Headers
  static const String contentTypeJson = 'application/json';
  static const String acceptJson = 'application/json';
}

/// Points de terminaison API
class ApiEndpoints {
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
}

/// Classe de base pour les exceptions
class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}

/// Exception serveur
class ServerException extends AppException {
  ServerException([String message = 'Erreur serveur survenue'])
    : super(message);
}

/// Exception de cache
class CacheException extends AppException {
  CacheException([String message = 'Erreur de cache survenue'])
    : super(message);
}

/// Exception réseau
class NetworkException extends AppException {
  NetworkException([String message = 'Erreur réseau survenue'])
    : super(message);
}

/// Exception de validation
class ValidationException extends AppException {
  ValidationException([String message = 'Erreur de validation survenue'])
    : super(message);
}

/// Exception d'authentification
class AuthException extends AppException {
  AuthException([String message = 'Erreur d\'authentification survenue'])
    : super(message);
}

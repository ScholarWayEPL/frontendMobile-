/// Classe de base pour les exceptions
class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}

/// Exception serveur
class ServerException extends AppException {
  ServerException([super.message = 'Erreur serveur survenue']);
}

/// Exception de cache
class CacheException extends AppException {
  CacheException([super.message = 'Erreur de cache survenue']);
}

/// Exception réseau
class NetworkException extends AppException {
  NetworkException([super.message = 'Erreur réseau survenue']);
}

/// Exception de validation
class ValidationException extends AppException {
  ValidationException([super.message = 'Erreur de validation survenue']);
}

/// Exception d'authentification
class AuthException extends AppException {
  AuthException([super.message = 'Erreur d\'authentification survenue']);
}

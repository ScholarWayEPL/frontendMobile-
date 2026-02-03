import 'package:equatable/equatable.dart';

/// Classe de base pour toutes les erreurs de l'application
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Erreurs liées au serveur
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Erreurs liées au cache
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Erreurs liées au réseau
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Erreurs de validation
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Erreurs d'authentification
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Erreurs génériques
class GeneralFailure extends Failure {
  const GeneralFailure(super.message);
}

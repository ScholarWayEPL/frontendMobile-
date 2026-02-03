import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

/// État de base pour l'authentification
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// État initial
final class AuthInitial extends AuthState {
  const AuthInitial();
}

/// État de chargement
final class AuthLoading extends AuthState {
  const AuthLoading();
}

/// État authentifié
final class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

/// État non authentifié
final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// État d'erreur
final class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

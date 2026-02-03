import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../bloc/auth_state.dart';
import '../../../../core/usecases/usecase.dart';

/// Notifier pour gérer l'état d'authentification
class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthNotifier({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _logoutUseCase = logoutUseCase,
       super(const AuthInitial());

  /// Connexion utilisateur
  Future<void> login({required String email, required String password}) async {
    state = const AuthLoading();

    final result = await _loginUseCase(
      LoginParams(email: email, password: password),
    );

    state = result.fold(
      (failure) => AuthError(failure.message),
      (user) => AuthAuthenticated(user),
    );
  }

  /// Inscription utilisateur
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    state = const AuthLoading();

    final result = await _registerUseCase(
      RegisterParams(email: email, password: password, name: name),
    );

    state = result.fold(
      (failure) => AuthError(failure.message),
      (user) => AuthAuthenticated(user),
    );
  }

  /// Déconnexion utilisateur
  Future<void> logout() async {
    state = const AuthLoading();

    final result = await _logoutUseCase(const NoParams());

    state = result.fold(
      (failure) => AuthError(failure.message),
      (_) => const AuthUnauthenticated(),
    );
  }

  /// Réinitialiser l'état
  void reset() {
    state = const AuthInitial();
  }
}

/// Provider pour le state notifier d'authentification
/// Note: Ce provider sera initialisé avec les dépendances dans injection_container.dart
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  throw UnimplementedError(
    'authProvider doit être overridé avec les dépendances appropriées',
  );
});

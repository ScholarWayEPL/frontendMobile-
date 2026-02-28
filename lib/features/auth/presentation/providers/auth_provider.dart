import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/register_bachelier_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../../../core/usecases/usecase.dart';
import '../state/auth_state.dart';

/// Notifier pour gérer l'état d'authentification
class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final RegisterBachelierUseCase _registerBachelierUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthNotifier({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required RegisterBachelierUseCase registerBachelierUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _registerBachelierUseCase = registerBachelierUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       super(const AuthInitial()) {
    checkAuthStatus();
  }

  /// Vérifier l'état d'authentification au démarrage
  Future<void> checkAuthStatus() async {
    state = const AuthLoading();

    final result = await _getCurrentUserUseCase(NoParams());

    state = result.fold(
      (failure) => const AuthUnauthenticated(),
      (user) => AuthAuthenticated(user),
    );
  }

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

  /// Inscription bachelier
  Future<void> registerBachelier({
    required String nom,
    required String prenom,
    required String email,
    required String motDePasse,
    required String telephone,
  }) async {
    state = const AuthLoading();

    final result = await _registerBachelierUseCase(
      RegisterBachelierParams(
        nom: nom,
        prenom: prenom,
        email: email,
        motDePasse: motDePasse,
        telephone: telephone,
      ),
    );

    state = result.fold(
      (failure) => AuthError(failure.message),
      (user) => AuthAuthenticated(user),
    );
  }

  /// Déconnexion utilisateur
  Future<void> logout() async {
    state = const AuthLoading();
    // Plus d'appel backend selon la demande utilisateur
    state = const AuthUnauthenticated();
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

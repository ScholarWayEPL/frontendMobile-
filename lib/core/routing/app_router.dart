import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/auth_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/unauthorized_role_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/complete_profile_screen.dart';
import '../../features/profile/presentation/screens/document_upload_screen.dart';
import '../../features/auth/presentation/state/auth_state.dart';
import '../../injection_container.dart';

/// Un ChangeNotifier qui notifie GoRouter quand l'état d'authentification change.
/// Cela évite de recréer l'instance de GoRouter à chaque changement d'état.
class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      // Ne notifier que si l'état change réellement de type (ex: Loading -> Authenticated)
      // ou si c'est important pour la redirection.
      notifyListeners();
    });
  }
}

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: notifier,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(path: '/', builder: (context, state) => const OnboardingScreen()),
      GoRoute(
        path: '/login',
        builder: (context, state) => const AuthScreen(initialTab: 0),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const AuthScreen(initialTab: 1),
      ),
      GoRoute(
        path: '/register-steps',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/unauthorized',
        builder: (context, state) => const UnauthorizedRoleScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
        routes: [
          GoRoute(
            path: 'complete',
            builder: (context, state) => const CompleteProfileScreen(),
          ),
          GoRoute(
            path: 'documents',
            builder: (context, state) => const DocumentUploadScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);
      final matchedLocation = state.matchedLocation;

      // Si on est en chargement initial, on ne redirige pas encore
      // pour éviter les flashs d'écrans non désirés.
      if (authState is AuthLoading || authState is AuthInitial) {
        return null;
      }

      final isAuthenticated = authState is AuthAuthenticated;
      final isUnauthenticated =
          authState is AuthUnauthenticated || authState is AuthError;

      // Destinations de login/onboarding
      final isAuthPage =
          matchedLocation == '/login' || matchedLocation == '/register';
      final isOnboarding = matchedLocation == '/';

      if (isUnauthenticated) {
        // Si non connecté et pas sur une page publique -> redirection vers login (ou on reste sur onboarding)
        if (!isAuthPage && !isOnboarding) return '/login';
        return null;
      }

      if (isAuthenticated) {
        final user = authState.user;
        final hasBachelierRole =
            user.role == 'ROLE_BACHELIER' ||
            (user.role?.contains('ROLE_BACHELIER') ?? false);

        // Si pas le bon rôle, forcer vers /unauthorized (sauf si déjà là)
        if (!hasBachelierRole) {
          if (matchedLocation != '/unauthorized') return '/unauthorized';
          return null;
        }

        // Si bachelier et sur une page inappropriée
        // 1. Depuis la page d'inscription -> vers les étapes du parcours
        if (matchedLocation == '/register') {
          return '/register-steps';
        }

        // 2. Depuis login, onboarding ou unauthorized (si accès rétabli) -> vers /home
        if (matchedLocation == '/login' ||
            matchedLocation == '/unauthorized' ||
            isOnboarding) {
          return '/home';
        }
      }

      return null;
    },
  );
});

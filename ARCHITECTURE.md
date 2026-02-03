# ScholarWay - Projet Flutter Clean Architecture

## Structure du Projet

Ce projet suit les principes de la Clean Architecture avec une organisation par fonctionnalités et **Riverpod** pour la gestion d'état.

### Couches de l'Architecture

#### 1. Couche Core (`lib/core/`)
Contient le code partagé utilisé dans toute l'application :
- **error/**: Gestion des exceptions et erreurs
  - `failures.dart`: Classes de base pour les erreurs
  - `exceptions.dart`: Exceptions personnalisées
- **network/**: Utilitaires de connectivité réseau
  - `network_info.dart`: Vérificateur de connexion Internet
- **usecases/**: Classe de base pour les cas d'usage
  - `usecase.dart`: Template abstrait pour les cas d'usage
- **utils/**: Classes utilitaires
  - `constants.dart`: Constantes de l'application
  - `validators.dart`: Utilitaires de validation
  - `logger.dart`: Utilitaire de journalisation

#### 2. Couche Features (`lib/features/`)
Chaque fonctionnalité suit la même structure avec trois sous-couches :

##### Exemple : Fonctionnalité Auth (`lib/features/auth/`)

**Couche Domain** (`domain/`)
- Logique métier pure, aucune dépendance à Flutter ou packages externes
- `entities/`: Objets métier (ex: User)
- `repositories/`: Interfaces abstraites des repositories
- `usecases/`: Cas d'usage métier (ex: LoginUseCase, RegisterUseCase)

**Couche Data** (`data/`)
- Implémentation des repositories du domaine
- `datasources/`: Sources de données distantes (API) et locales (cache)
- `models/`: Modèles de données avec sérialisation JSON
- `repositories/`: Implémentations des repositories

**Couche Presentation** (`presentation/`)
- Code lié à l'interface utilisateur
- `providers/`: Providers Riverpod pour la gestion d'état
  - `auth_provider.dart`: StateNotifier pour l'authentification
- `bloc/`: Classes d'état (states)
  - `auth_state.dart`: États d'authentification
- `pages/`: Widgets d'écran avec exemples d'utilisation
- `widgets/`: Composants UI réutilisables avec exemples

### Gestion d'État avec Riverpod

Le projet utilise **flutter_riverpod** pour la gestion d'état moderne et performante :

- **StateNotifierProvider** : Pour gérer les états complexes avec logique métier
- **Provider** : Pour l'injection de dépendances
- **ConsumerWidget** : Widgets qui écoutent les changements d'état
- **ConsumerStatefulWidget** : Pour les widgets avec état local

### Injection de Dépendances

`lib/injection_container.dart` - Configuration des providers Riverpod pour l'injection de dépendances

Le projet utilise **Dio** comme client HTTP pour les requêtes réseau, avec une configuration centralisée dans `lib/core/network/dio_client.dart`.

Exemple de providers configurés :
```dart
// Provider pour Dio client
final dioProvider = Provider<Dio>((ref) {
  return DioClient.createDio();
});

// Provider pour le repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
    localDataSource: ref.read(authLocalDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
});

// Provider pour le state notifier
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    loginUseCase: ref.read(loginUseCaseProvider),
    registerUseCase: ref.read(registerUseCaseProvider),
    logoutUseCase: ref.read(logoutUseCaseProvider),
  );
});
```

### Configuration Dio

Le client Dio est configuré dans `lib/core/network/dio_client.dart` avec :
- **Base URL** : Configuration centralisée
- **Timeouts** : Connexion, réception, envoi
- **Headers** : Content-Type, Accept, Authorization
- **Intercepteurs** : 
  - Authentification automatique (token)
  - Logger pour le debug (pretty_dio_logger)
  - Gestion des erreurs globales
- **Gestion des erreurs** : Conversion automatique des DioException en exceptions métier

### Dépendances Clés

```yaml
dependencies:
  # Gestion d'état avec Riverpod
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.6.1
  
  # Utilitaires
  equatable: ^2.0.5
  
  # Programmation fonctionnelle
  dartz: ^0.10.1
  
  # Injection de dépendances (optionnel avec Riverpod)
  get_it: ^8.0.4
  
  # Réseau avec Dio
  dio: ^5.7.0
  pretty_dio_logger: ^1.4.0
  internet_connection_checker_plus: ^2.5.2
  
  # Stockage local
  shared_preferences: ^2.3.3

dev_dependencies:
  # Générateur de code pour Riverpod
  build_runner: ^2.4.14
  riverpod_generator: ^2.6.3
```

### Utilisation de Riverpod dans l'Application

#### 1. Point d'entrée (main.dart)
```dart
void main() {
  runApp(
    const ProviderScope(  // Obligatoire pour Riverpod
      child: ScholarWayApp(),
    ),
  );
}
```

#### 2. Utilisation dans un Widget
```dart
class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Écouter l'état
    final authState = ref.watch(authNotifierProvider);
    
    // Appeler une action
    ref.read(authNotifierProvider.notifier).login(
      email: email,
      password: password,
    );
    
    return Scaffold(...);
  }
}
```

#### 3. Écouter les changements pour la navigation
```dart
ref.listen<AuthState>(authNotifierProvider, (previous, next) {
  if (next is AuthAuthenticated) {
    Navigator.pushReplacementNamed('/home');
  }
});
```

### Démarrage

1. ✅ Les dépendances sont déjà ajoutées dans `pubspec.yaml`
2. Exécuter `flutter pub get`
3. Les providers sont configurés dans `injection_container.dart`
4. Implémenter les pages UI en utilisant `ConsumerWidget`
5. Implémenter les sources de données (API et stockage local)
6. Optionnel : Utiliser `build_runner` pour générer du code Riverpod

### Commandes Utiles

```bash
# Installer les dépendances
flutter pub get

# Générer le code (si vous utilisez riverpod_generator)
dart run build_runner build --delete-conflicting-outputs

# Watch mode pour génération automatique
dart run build_runner watch
```

### Avantages de l'Architecture

- **Séparation des préoccupations** : Chaque couche a une responsabilité spécifique
- **Testabilité** : Facile d'écrire des tests unitaires pour chaque couche
- **Maintenabilité** : Les changements dans une couche n'affectent pas les autres
- **Évolutivité** : Facile d'ajouter de nouvelles fonctionnalités
- **Réactivité** : Riverpod offre une gestion d'état réactive et performante
- **Type-safe** : Riverpod est complètement type-safe
- **Compile-time safety** : Les erreurs sont détectées à la compilation
- **Pas de BuildContext requis** : Accès aux providers depuis n'importe où
- **Client HTTP moderne** : Dio offre des fonctionnalités avancées (intercepteurs, annulation, progression, etc.)
- **Gestion d'erreur robuste** : Conversion automatique des erreurs réseau en exceptions métier

### Riverpod vs BLoC

**Pourquoi Riverpod ?**
- ✅ Plus simple et moins verbeux
- ✅ Injection de dépendances intégrée
- ✅ Pas besoin de BuildContext
- ✅ Meilleure performance (recalcul optimisé)
- ✅ Type-safe par défaut
- ✅ Pas de boilerplate inutile
- ✅ Testabilité excellente

### Dio vs HTTP

**Pourquoi Dio ?**
- ✅ Intercepteurs puissants (auth, logging, retry)
- ✅ Gestion automatique des timeouts
- ✅ Support natif des FormData et multipart
- ✅ Annulation de requêtes
- ✅ Progression de téléchargement/upload
- ✅ Gestion d'erreur avancée
- ✅ Transformation automatique des réponses
- ✅ Support des certificats SSL personnalisés

### Prochaines Étapes

1. ✅ Packages Riverpod et Dio ajoutés dans pubspec.yaml
2. ✅ Providers configurés dans injection_container.dart
3. ✅ Client Dio configuré avec intercepteurs
4. ✅ AuthRemoteDataSource implémenté avec Dio
5. ✅ Gestion d'erreur complète avec DioException
6. Implémenter les écrans UI avec ConsumerWidget
7. Configurer SharedPreferences pour le stockage local
8. Ajouter d'autres fonctionnalités en suivant la même structure
9. Implémenter le refresh token dans l'intercepteur Dio
10. Configurer les tests unitaires et d'intégration

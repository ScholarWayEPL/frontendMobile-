# Bonnes Pratiques - Clean Architecture

## ✅ Améliorations Apportées

### 1. **Séparation Domain / Data**

#### ❌ Avant (Problématique)
```dart
// domain/entities/user.dart
import 'package:equatable/equatable.dart';  // ❌ Dépendance externe

class User extends Equatable { ... }

// data/models/user_model.dart
class UserModel extends User { ... }  // ❌ Héritage = couplage fort
```

**Problèmes :**
- Le domaine dépend d'un package externe (Equatable)
- Violation du principe d'indépendance du domaine
- Couplage fort via l'héritage
- Difficile à tester en isolation

#### ✅ Après (Solution)
```dart
// domain/entities/user.dart
class User {  // ✅ Pure Dart, aucune dépendance
  // Implémentation manuelle de == et hashCode
  @override
  bool operator ==(Object other) { ... }
  
  @override
  int get hashCode { ... }
}

// data/models/user_model.dart
import 'package:equatable/equatable.dart';  // ✅ OK dans la couche data

class UserModel extends Equatable {  // ✅ Composition, pas d'héritage
  // Conversion explicite
  User toEntity() { ... }
  factory UserModel.fromEntity(User user) { ... }
}
```

**Avantages :**
- ✅ Domaine 100% indépendant
- ✅ Pas de fuite de dépendances
- ✅ Conversion explicite entre les couches
- ✅ Testabilité maximale

---

## 📋 Questions / Réponses

### Q1: À quoi sert Equatable ?

**Réponse :** Equatable simplifie la comparaison d'objets par valeur.

**Utilisation :**
```dart
class UserModel extends Equatable {
  final String id;
  final String email;
  
  @override
  List<Object?> get props => [id, email];
}

// Comparaison automatique
final user1 = UserModel(id: '1', email: 'test@test.com');
final user2 = UserModel(id: '1', email: 'test@test.com');

print(user1 == user2);  // true (mêmes props)
```

**Quand l'utiliser :**
- ✅ Dans la couche **Data** (models)
- ✅ Dans la couche **Presentation** (states)
- ❌ Dans la couche **Domain** (entities) → JAMAIS !

**Pourquoi pas dans Domain ?**
- Le domaine doit être pur (pas de dépendances externes)
- Facilite les tests sans mocks
- Permet la réutilisation dans d'autres contextes

---

### Q2: Pourquoi UserModel n'hérite plus de User ?

**Principe : Composition > Héritage**

**Raisons :**

1. **Séparation des responsabilités**
   - `User` (Domain) : Logique métier pure
   - `UserModel` (Data) : Sérialisation JSON

2. **Indépendance du domaine**
   - Le domaine ne connaît rien de la couche data
   - Pas de dépendances "vers le bas"

3. **Flexibilité**
   - Le model peut avoir des champs différents de l'entité
   - Exemple : `UserModel` peut avoir `avatarUrl` non présent dans `User`

4. **Conversion explicite**
   ```dart
   // Clair et explicite
   final user = userModel.toEntity();
   
   // vs héritage (implicite, confusion)
   final user = userModel;  // Est-ce un model ou une entity ?
   ```

---

### Q3: Séparation des responsabilités est-elle bien faite ?

**✅ OUI, maintenant elle l'est !**

#### Architecture en couches

```
┌─────────────────────────────────────┐
│         PRESENTATION                │
│  (Riverpod, States, Pages)         │
│  Dépend de: Domain                  │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│           DOMAIN                     │
│  (Entities, UseCases, Repos)       │
│  Dépend de: RIEN                    │  ← 100% indépendant
└─────────────────────────────────────┘
              ↑
┌─────────────────────────────────────┐
│            DATA                      │
│  (Models, DataSources, RepoImpl)   │
│  Dépend de: Domain                  │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│          EXTERNAL                    │
│  (Dio, SharedPrefs, etc.)          │
└─────────────────────────────────────┘
```

**Règle d'or : La dépendance va toujours vers le domaine**

---

## ✅ Bonnes Pratiques Respectées

### 1. **Dependency Rule**
```dart
// ✅ Data dépend de Domain
class AuthRepositoryImpl implements AuthRepository {
  User toEntity() { ... }  // Conversion explicite
}

// ❌ Domain ne dépend JAMAIS de Data
class User {
  // Pas d'import de UserModel ici !
}
```

### 2. **Single Responsibility Principle (SRP)**
```dart
// User : Logique métier uniquement
class User {
  bool canEditProfile() { ... }
  bool isEmailVerified() { ... }
}

// UserModel : Sérialisation uniquement
class UserModel {
  factory fromJson(Map<String, dynamic> json) { ... }
  Map<String, dynamic> toJson() { ... }
}
```

### 3. **Open/Closed Principle**
```dart
// Repository abstrait (ouvert à l'extension)
abstract class AuthRepository {
  Future<Either<Failure, User>> login(...);
}

// Implémentation concrète (fermé à la modification)
class AuthRepositoryImpl implements AuthRepository { ... }
```

### 4. **Interface Segregation**
```dart
// Interfaces spécifiques
abstract class AuthRemoteDataSource { ... }
abstract class AuthLocalDataSource { ... }

// Pas une grosse interface "DataSource" avec tout dedans
```

### 5. **Dependency Inversion**
```dart
// UseCase dépend de l'abstraction, pas de l'implémentation
class LoginUseCase {
  final AuthRepository repository;  // Interface, pas RepoImpl
  
  LoginUseCase(this.repository);
}
```

---

## 🏗️ Architecture par Couche

### **Domain Layer** (Cœur métier)
```dart
✅ Entités pures (User)
✅ Cas d'usage (LoginUseCase)
✅ Interfaces de repositories (AuthRepository)
✅ Aucune dépendance externe
✅ Testable sans mocks
```

### **Data Layer** (Implémentation)
```dart
✅ Models avec sérialisation (UserModel + Equatable)
✅ Implémentations de repositories (AuthRepositoryImpl)
✅ DataSources (Remote avec Dio, Local avec SharedPrefs)
✅ Conversion Model ↔ Entity
```

### **Presentation Layer** (UI)
```dart
✅ States avec Equatable (AuthState)
✅ Providers Riverpod (AuthNotifier)
✅ Pages/Widgets (ConsumerWidget)
✅ Ne manipule que des entités Domain
```

---

## 🎯 Checklist de Qualité

### Domain
- [x] Aucune dépendance externe
- [x] Entités avec == et hashCode manuels
- [x] Cas d'usage avec injection de dépendances
- [x] Interfaces de repositories pures

### Data
- [x] Models avec Equatable
- [x] Conversion explicite toEntity() / fromEntity()
- [x] Gestion des erreurs (exceptions → failures)
- [x] DataSources séparés (remote/local)

### Présentation
- [x] States avec Equatable
- [x] Providers Riverpod
- [x] Pas de logique métier dans les widgets
- [x] Utilise uniquement les entités Domain

---

## 📚 Ressources

- **Clean Architecture** : Robert C. Martin
- **SOLID Principles** : Design patterns
- **Riverpod** : State management moderne
- **Dio** : Client HTTP avancé

---

## 🔄 Flux de Données

```
User Action (UI)
       ↓
Provider Riverpod (AuthNotifier)
       ↓
UseCase (LoginUseCase)
       ↓
Repository Interface (AuthRepository)
       ↓
Repository Impl (AuthRepositoryImpl)
       ↓
DataSource (AuthRemoteDataSource + Dio)
       ↓
API (JSON Response)
       ↓
Model (UserModel.fromJson)
       ↓
Entity (userModel.toEntity())
       ↓
Repository → UseCase → Provider
       ↓
State Update (AuthState)
       ↓
UI Rebuild
```

**Chaque couche a sa responsabilité claire et ne fait qu'une seule chose !**

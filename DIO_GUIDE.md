# Configuration Dio pour ScholarWay

Ce document explique la configuration et l'utilisation de Dio dans le projet.

## Structure

```
lib/
├── core/
│   └── network/
│       ├── dio_client.dart      # Configuration Dio
│       └── network_info.dart    # Vérification connectivité
└── features/
    └── auth/
        └── data/
            └── datasources/
                └── auth_remote_datasource.dart  # Utilisation de Dio
```

## Configuration Dio

### BaseOptions

```dart
BaseOptions(
  baseUrl: 'https://api.scholarway.com',
  connectTimeout: Duration(milliseconds: 30000),
  receiveTimeout: Duration(milliseconds: 30000),
  sendTimeout: Duration(milliseconds: 30000),
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
)
```

### Intercepteurs

#### 1. AuthInterceptor
- Ajoute automatiquement le token aux requêtes
- Gère le refresh token en cas d'expiration (401)
- Peut être étendu pour d'autres logiques d'auth

#### 2. PrettyDioLogger
- Affiche les requêtes et réponses de manière lisible
- À désactiver en production pour les performances
- Utile pour le debugging

```dart
PrettyDioLogger(
  requestHeader: true,
  requestBody: true,
  responseBody: true,
  error: true,
  compact: true,
)
```

## Gestion des Erreurs

### Types d'erreurs Dio

```dart
switch (error.type) {
  case DioExceptionType.connectionTimeout:
  case DioExceptionType.sendTimeout:
  case DioExceptionType.receiveTimeout:
    // Timeout
    
  case DioExceptionType.badResponse:
    // Erreur serveur (4xx, 5xx)
    
  case DioExceptionType.cancel:
    // Requête annulée
    
  case DioExceptionType.connectionError:
    // Pas de connexion
    
  case DioExceptionType.badCertificate:
    // Certificat SSL invalide
    
  case DioExceptionType.unknown:
    // Erreur inconnue
}
```

### Conversion en exceptions métier

Les `DioException` sont automatiquement converties en exceptions métier :
- `NetworkException` : Problèmes de connexion, timeout
- `ServerException` : Erreurs serveur (5xx)
- `AuthException` : Erreurs d'authentification (401, 403)

## Utilisation

### Exemple de requête POST

```dart
final response = await dio.post(
  '/auth/login',
  data: {
    'email': email,
    'password': password,
  },
);

if (response.statusCode == 200) {
  return UserModel.fromJson(response.data['data']);
}
```

### Exemple de requête GET

```dart
final response = await dio.get('/users/me');

if (response.statusCode == 200) {
  return UserModel.fromJson(response.data);
}
```

### Gestion des erreurs

```dart
try {
  final response = await dio.post('/endpoint', data: data);
  // Traiter la réponse
} on DioException catch (e) {
  throw _handleDioError(e);
} catch (e) {
  throw ServerException('Erreur: ${e.toString()}');
}
```

## Fonctionnalités Avancées

### 1. Annulation de requête

```dart
final cancelToken = CancelToken();

// Faire la requête
dio.get('/endpoint', cancelToken: cancelToken);

// Annuler si nécessaire
cancelToken.cancel('Annulé par l\'utilisateur');
```

### 2. Progression de téléchargement

```dart
await dio.download(
  '/file',
  savePath,
  onReceiveProgress: (received, total) {
    final progress = (received / total * 100).toStringAsFixed(0);
    print('Progression: $progress%');
  },
);
```

### 3. Upload de fichier

```dart
final formData = FormData.fromMap({
  'file': await MultipartFile.fromFile(filePath),
  'name': 'fichier.pdf',
});

await dio.post('/upload', data: formData);
```

### 4. Retry automatique

Pour implémenter un retry automatique, ajouter un intercepteur :

```dart
class RetryInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionTimeout && 
        retryCount < maxRetries) {
      retryCount++;
      // Retry la requête
      try {
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        return super.onError(err, handler);
      }
    }
    super.onError(err, handler);
  }
}
```

## Best Practices

1. **Centraliser la configuration** : Une seule instance de Dio configurée
2. **Utiliser des intercepteurs** : Pour la logique commune (auth, logging)
3. **Gérer les erreurs** : Convertir toutes les exceptions Dio
4. **Timeouts appropriés** : Adapter selon le type de requête
5. **Logger en développement uniquement** : Désactiver en production
6. **Gestion des tokens** : Rafraîchir automatiquement si expiré
7. **Validation SSL** : Gérer les certificats en production

## Tests

### Mock Dio pour les tests

```dart
class MockDio extends Mock implements Dio {}

test('should return user on successful login', () async {
  final mockDio = MockDio();
  final dataSource = AuthRemoteDataSourceImpl(dio: mockDio);
  
  when(mockDio.post(any, data: anyNamed('data')))
    .thenAnswer((_) async => Response(
      data: {'data': userJson},
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    ));
  
  final result = await dataSource.login(email: 'test@test.com', password: 'pass');
  
  expect(result, isA<UserModel>());
});
```

## Ressources

- [Documentation Dio](https://pub.dev/packages/dio)
- [Pretty Dio Logger](https://pub.dev/packages/pretty_dio_logger)
- [Intercepteurs personnalisés](https://github.com/cfug/dio/blob/main/dio/README.md#interceptors)

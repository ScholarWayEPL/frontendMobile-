import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/user_model.dart';

/// Source de données distante abstraite pour l'authentification
/// Gère les appels API
abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});

  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  });

  Future<void> logout();

  Future<UserModel> getCurrentUser();
}

/// Implémentation de la source de données distante avec Dio
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(response.data['data'] ?? response.data);
      } else {
        throw ServerException(
          response.data['message'] ?? 'Erreur lors de la connexion',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException('Erreur inattendue: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.register,
        data: {'email': email, 'password': password, 'name': name},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(response.data['data'] ?? response.data);
      } else {
        throw ServerException(
          response.data['message'] ?? 'Erreur lors de l\'inscription',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException('Erreur inattendue: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post(ApiEndpoints.logout);
    } on DioException catch (e) {
      // Le logout peut échouer côté serveur mais on continue quand même
      if (e.type != DioExceptionType.connectionTimeout &&
          e.type != DioExceptionType.receiveTimeout) {
        throw _handleDioError(e);
      }
    } catch (e) {
      throw ServerException('Erreur lors de la déconnexion: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await dio.get('/auth/me');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data['data'] ?? response.data);
      } else {
        throw ServerException(
          response.data['message'] ?? 'Impossible de récupérer l\'utilisateur',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException('Erreur inattendue: ${e.toString()}');
    }
  }

  /// Gestion centralisée des erreurs Dio
  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException('Délai d\'attente dépassé');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message =
            error.response?.data['message'] ??
            error.response?.statusMessage ??
            'Erreur serveur';

        if (statusCode == 401) {
          return AuthException('Non autorisé: $message');
        } else if (statusCode == 403) {
          return AuthException('Accès interdit: $message');
        } else if (statusCode == 404) {
          return ServerException('Ressource non trouvée');
        } else if (statusCode != null && statusCode >= 500) {
          return ServerException('Erreur serveur: $message');
        }
        return ServerException(message);

      case DioExceptionType.cancel:
        return NetworkException('Requête annulée');

      case DioExceptionType.connectionError:
        return NetworkException(
          'Erreur de connexion. Vérifiez votre connexion internet.',
        );

      case DioExceptionType.badCertificate:
        return NetworkException('Certificat SSL invalide');

      case DioExceptionType.unknown:
        if (error.message?.contains('SocketException') ?? false) {
          return NetworkException('Pas de connexion internet');
        }
        return ServerException(
          error.message ?? 'Une erreur inconnue s\'est produite',
        );
    }
  }
}

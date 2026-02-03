import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../utils/constants.dart';

/// Configuration et création du client Dio
class DioClient {
  static Dio createDio({String? token}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: Duration(milliseconds: AppConstants.connectionTimeout),
        receiveTimeout: Duration(milliseconds: AppConstants.receiveTimeout),
        sendTimeout: Duration(milliseconds: AppConstants.sendTimeout),
        headers: {
          'Content-Type': AppConstants.contentTypeJson,
          'Accept': AppConstants.acceptJson,
          if (token != null) 'Authorization': 'Bearer $token',
        },
        validateStatus: (status) {
          // Accepter tous les status codes pour les gérer manuellement
          return status != null && status < 500;
        },
      ),
    );

    // Ajouter les intercepteurs
    dio.interceptors.add(_AuthInterceptor());

    // Logger pour le mode debug (désactiver en production)
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    return dio;
  }
}

/// Intercepteur pour gérer l'authentification et les tokens
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Ici, on peut ajouter le token dynamiquement depuis le storage
    // final token = await getTokenFromStorage();
    // if (token != null) {
    //   options.headers['Authorization'] = 'Bearer $token';
    // }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Traiter la réponse si nécessaire
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Gérer les erreurs globales (ex: refresh token)
    if (err.response?.statusCode == 401) {
      // Token expiré, on pourrait implémenter le refresh token ici
      // refreshToken().then((newToken) => retry(err.requestOptions));
    }

    super.onError(err, handler);
  }
}

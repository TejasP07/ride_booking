import 'package:dio/dio.dart';

import '../services/secure_storage_service.dart';
import 'dio_interceptor.dart';

class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://wa-peke-api.demohub.tech/api/v1/',

        connectTimeout: const Duration(seconds: 30),

        receiveTimeout: const Duration(seconds: 30),

        sendTimeout: const Duration(seconds: 30),

        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      DioInterceptor(secureStorageService: SecureStorageService()),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
}

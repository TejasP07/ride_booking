import 'package:dio/dio.dart';

import '../services/secure_storage_service.dart';

class DioInterceptor extends Interceptor {
  final SecureStorageService secureStorageService;

  DioInterceptor({required this.secureStorageService});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorageService.getToken();

    final path = options.path;

    final isAuthApi =
        path.contains('request-otp') || path.contains('verify-otp');

    if (!isAuthApi && token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Accept'] = 'application/json';

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await secureStorageService.clear();
    }

    super.onError(err, handler);
  }
}

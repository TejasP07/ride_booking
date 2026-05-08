import 'package:dio/dio.dart';

import '../../core/api/api_client.dart';
import '../../core/api/api_constants.dart';

class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource({required this.apiClient});

  Future<Response> requestOtp({required String mobile}) async {
    return await apiClient.dio.post(
      ApiConstants.requestOtp,
      data: {"mobile": mobile},
    );
  }

  Future<Response> verifyOtp({
    required String mobile,
    required String otp,
  }) async {
    return await apiClient.dio.post(
      ApiConstants.verifyOtp,
      data: {"mobile": mobile, "otp": otp},
    );
  }
}

import 'package:dio/dio.dart';

import '../../core/api/api_client.dart';
import '../../core/api/api_constants.dart';

class ServicesRemoteDataSource {
  final ApiClient apiClient;

  ServicesRemoteDataSource({required this.apiClient});

  Future<Response> getServices() async {
    return await apiClient.dio.get(ApiConstants.activeServices);
  }
}

import '../../domain/entities/service_entity.dart';

import '../../domain/repositories/service_repository.dart';

import '../datasource/services_remote_datasource.dart';

import '../mapper/active_service_mapper.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServicesRemoteDataSource remoteDataSource;

  ServiceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ActiveServiceEntity>> getActiveServices() async {
    try {
      final response = await remoteDataSource.getServices();

      _logResponse(response.data);

      final List services = response.data['data']['data'] as List? ?? [];

      return services.map((json) {
        return ActiveServiceMapper.toEntity(json);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// DEBUG LOGGING
  void _logResponse(dynamic response) {
    print(
      "SERVICE RESPONSE => "
      "$response",
    );
  }
}

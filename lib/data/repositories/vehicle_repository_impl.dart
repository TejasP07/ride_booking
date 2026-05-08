import 'dart:io';

import '../../domain/entities/vehicle_entity.dart';

import '../../domain/repositories/vehicle_repository.dart';

import '../datasource/vehicle_remote_datasource.dart';

import '../mapper/vehicle_mapper.dart';
import '../models/vehicle/vehicle_model.dart';

class VehicleRepositoryImpl implements VehicleRepository {
  final VehicleRemoteDataSource remoteDataSource;

  VehicleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<VehicleEntity>> getVehicles() async {
    final response = await remoteDataSource.getVehicles();

    final List vehicles = response.data['data'] as List? ?? [];

    return vehicles.map((json) {
      final model = VehicleModel.fromJson(json);

      return VehicleMapper.toEntity(model);
    }).toList();
  }

  @override
  Future<void> addVehicle({
    required String regNo,

    required String vehicleType,

    required String vehicleName,

    required File image,
  }) {
    return remoteDataSource.addVehicle(
      regNo: regNo,

      vehicleType: vehicleType,

      vehicleName: vehicleName,

      image: image,
    );
  }

  @override
  Future<void> deleteVehicle(int id) {
    return remoteDataSource.deleteVehicle(id);
  }
}

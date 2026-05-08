import 'dart:io';

import '../entities/vehicle_entity.dart';

abstract class VehicleRepository {
  Future<List<VehicleEntity>> getVehicles();

  Future<void> addVehicle({
    required String regNo,

    required String vehicleType,

    required String vehicleName,

    required File image,
  });

  Future<void> deleteVehicle(int id);
}

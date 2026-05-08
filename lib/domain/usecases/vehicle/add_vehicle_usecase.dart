import 'dart:io';

import '../../repositories/vehicle_repository.dart';

class AddVehicleUseCase {
  final VehicleRepository repository;

  AddVehicleUseCase(this.repository);

  Future<void> call({
    required String regNo,

    required String vehicleType,

    required String vehicleName,

    required File image,
  }) {
    return repository.addVehicle(
      regNo: regNo,

      vehicleType: vehicleType,

      vehicleName: vehicleName,

      image: image,
    );
  }
}

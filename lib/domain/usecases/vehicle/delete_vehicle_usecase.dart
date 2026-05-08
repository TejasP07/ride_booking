import '../../repositories/vehicle_repository.dart';

class DeleteVehicleUseCase {
  final VehicleRepository repository;

  DeleteVehicleUseCase(this.repository);

  Future<void> call(int id) {
    return repository.deleteVehicle(id);
  }
}

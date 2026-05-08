import '../../domain/entities/vehicle_entity.dart';
import '../models/vehicle/vehicle_model.dart';

class VehicleMapper {
  static VehicleEntity toEntity(VehicleModel model) {
    return VehicleEntity(
      id: model.id,

      regNo: model.regNo,

      vehicleType: model.vehicleType,

      vehicleName: model.vehicleName,

      vehicleImages: model.vehicleImages,
    );
  }
}

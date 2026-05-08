class VehicleModel {
  final int id;

  final String regNo;

  final String vehicleType;

  final String vehicleName;

  final List<String> vehicleImages;

  VehicleModel({
    required this.id,

    required this.regNo,

    required this.vehicleType,

    required this.vehicleName,

    required this.vehicleImages,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] ?? 0,

      regNo: json['reg_no'] ?? '',

      vehicleType: json['vehicle_type'] ?? '',

      vehicleName: json['vehicle_name'] ?? '',

      vehicleImages: List<String>.from(json['vehicle_image'] ?? []),
    );
  }
}

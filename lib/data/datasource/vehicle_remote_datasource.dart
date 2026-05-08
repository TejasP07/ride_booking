import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/api/api_client.dart';
import '../../core/api/api_constants.dart';

class VehicleRemoteDataSource {
  final ApiClient apiClient;

  VehicleRemoteDataSource({required this.apiClient});

  Future<Response> getVehicles() async {
    return await apiClient.dio.get(ApiConstants.vehicles);
  }

  Future<Response> addVehicle({
    required String regNo,
    required String vehicleType,
    required String vehicleName,
    required File image,
  }) async {
    FormData formData = FormData.fromMap({
      "reg_no": regNo,

      "vehicle_type": vehicleType,

      "vehicle_name": vehicleName,

      "vehicle_image": await MultipartFile.fromFile(image.path),
    });

    return await apiClient.dio.post(ApiConstants.vehicles, data: formData);
  }

  Future<Response> deleteVehicle(int id) async {
    return await apiClient.dio.delete("${ApiConstants.vehicles}/$id");
  }
}

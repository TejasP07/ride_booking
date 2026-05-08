import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/entities/vehicle_entity.dart';
import '../../../domain/usecases/vehicle/add_vehicle_usecase.dart';

import '../../../domain/usecases/vehicle/delete_vehicle_usecase.dart';

import '../../../domain/usecases/vehicle/get_vehicles_usecase.dart';

enum VehicleState { loading, loaded, empty, error }

class VehicleProvider extends ChangeNotifier {
  final GetVehiclesUseCase getVehiclesUseCase;

  final AddVehicleUseCase addVehicleUseCase;

  final DeleteVehicleUseCase deleteVehicleUseCase;

  VehicleProvider({
    required this.getVehiclesUseCase,

    required this.addVehicleUseCase,

    required this.deleteVehicleUseCase,
  });

  VehicleState state = VehicleState.loading;

  bool isAddingVehicle = false;

  List<VehicleEntity> vehicles = [];

  File? selectedImage;

  String selectedVehicleType = "";

  bool isPickingImage = false;

  final ImagePicker picker = ImagePicker();

  int? deletingVehicleId;

  Future<void> pickImage() async {
    try {
      isPickingImage = true;

      notifyListeners();

      final picked = await picker.pickImage(
        source: ImageSource.gallery,

        imageQuality: 70,
      );

      if (picked != null) {
        selectedImage = File(picked.path);
      }
    } finally {
      isPickingImage = false;

      notifyListeners();
    }
  }

  void resetVehicleForm() {
    selectedImage = null;

    isPickingImage = false;

    isAddingVehicle = false;

    selectedVehicleType = "";

    notifyListeners();
  }

  Future<void> getVehicles() async {
    try {
      state = VehicleState.loading;

      notifyListeners();

      vehicles = await getVehiclesUseCase();

      if (vehicles.isEmpty) {
        state = VehicleState.empty;
      } else {
        state = VehicleState.loaded;
      }
    } catch (e) {
      state = VehicleState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> addVehicle({
    required String regNo,
    required String vehicleType,
    required String vehicleName,
  }) async {
    try {
      if (selectedImage == null) {
        return false;
      }

      isAddingVehicle = true;
      notifyListeners();

      await addVehicleUseCase(
        regNo: regNo,

        vehicleType: vehicleType,

        vehicleName: vehicleName,

        image: selectedImage!,
      );

      selectedImage = null;

      await getVehicles();

      return true;
    } catch (e) {
      return false;
    } finally {
      isAddingVehicle = false;
      notifyListeners();
    }
  }

  Future<void> deleteVehicle(int id) async {
    try {
      deletingVehicleId = id;

      notifyListeners();

      await deleteVehicleUseCase(id);

      vehicles.removeWhere((e) => e.id == id);
    } catch (e) {
      rethrow;
    } finally {
      deletingVehicleId = null;

      notifyListeners();
    }
  }

  void selectVehicleType(String type) {
    selectedVehicleType = type;

    notifyListeners();
  }
}

import 'package:flutter/material.dart';

import '../../../domain/entities/service_entity.dart';
import '../../../domain/usecases/services/get_active_services_usecase.dart';

enum ServiceState { loading, loaded, empty, error }

class ActiveServicesProvider extends ChangeNotifier {
  final GetActiveServicesUseCase getActiveServicesUseCase;

  ActiveServicesProvider({required this.getActiveServicesUseCase});

  ServiceState state = ServiceState.loading;

  List<ActiveServiceEntity> services = [];

  Future<void> getServices() async {
    try {
      state = ServiceState.loading;

      notifyListeners();

      services = await getActiveServicesUseCase();

      if (services.isEmpty) {
        state = ServiceState.empty;
      } else {
        state = ServiceState.loaded;
      }
    } catch (e) {
      state = ServiceState.error;
    } finally {
      notifyListeners();
    }
  }
}

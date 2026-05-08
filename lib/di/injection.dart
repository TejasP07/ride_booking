import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/api/api_client.dart';
import '../core/services/secure_storage_service.dart';

import '../data/datasource/auth_remote_datasource.dart';
import '../data/datasource/services_remote_datasource.dart';
import '../data/datasource/vehicle_remote_datasource.dart';

import '../data/repositories/auth_repository_impl.dart';
import '../data/repositories/service_repository_impl.dart';
import '../data/repositories/vehicle_repository_impl.dart';

import '../domain/usecases/auth/request_otp_usecase.dart';
import '../domain/usecases/auth/verify_otp_usecase.dart';

import '../domain/usecases/services/get_active_services_usecase.dart';

import '../domain/usecases/vehicle/add_vehicle_usecase.dart';
import '../domain/usecases/vehicle/delete_vehicle_usecase.dart';
import '../domain/usecases/vehicle/get_vehicles_usecase.dart';

import '../presentation/auth/provider/auth_provider.dart';

import '../presentation/navigation/provider/navigation_provider.dart';

import '../presentation/onboarding/provider/onboarding_provider.dart';
import '../presentation/services/provider/active_services_provider.dart';

import '../presentation/splash/provider/splash_provider.dart';

import '../presentation/vehicle/provider/vehicle_provider.dart';

import '../presentation/settings/provider/settings_provider.dart';

import '../core/services/localization_service.dart';
import '../presentation/vehicle/provider/vehicle_type_provider.dart';

final apiClient = ApiClient();

final secureStorageService = SecureStorageService();

final localizationService = LocalizationService();

List<SingleChildWidget> providers = [
  /// SPLASH
  ChangeNotifierProvider(
    create: (_) => SplashProvider(secureStorageService: secureStorageService),
  ),

  /// AUTH
  ChangeNotifierProvider(
    create: (_) {
      final repository = AuthRepositoryImpl(
        remoteDataSource: AuthRemoteDataSource(apiClient: apiClient),
      );

      return AuthProvider(
        requestOtpUseCase: RequestOtpUseCase(repository),

        verifyOtpUseCase: VerifyOtpUseCase(repository),

        secureStorageService: secureStorageService,
      );
    },
  ),

  /// SERVICES
  ChangeNotifierProvider(
    create: (_) {
      final repository = ServiceRepositoryImpl(
        remoteDataSource: ServicesRemoteDataSource(apiClient: apiClient),
      );

      return ActiveServicesProvider(
        getActiveServicesUseCase: GetActiveServicesUseCase(repository),
      );
    },
  ),

  /// VEHICLE
  ChangeNotifierProvider(
    create: (_) {
      final repository = VehicleRepositoryImpl(
        remoteDataSource: VehicleRemoteDataSource(apiClient: apiClient),
      );

      return VehicleProvider(
        getVehiclesUseCase: GetVehiclesUseCase(repository),

        addVehicleUseCase: AddVehicleUseCase(repository),

        deleteVehicleUseCase: DeleteVehicleUseCase(repository),
      );
    },
  ),

  ChangeNotifierProvider(
    create:
        (_) => SettingsProvider(
          localizationService: LocalizationService(),

          secureStorageService: secureStorageService,
        ),
  ),

  /// NAVIGATION
  ChangeNotifierProvider(create: (_) => NavigationProvider()),

  ChangeNotifierProvider(
    create:
        (_) => OnboardingProvider(secureStorageService: SecureStorageService()),
  ),
];

import 'package:go_router/go_router.dart';

import '../presentation/onboarding/screens/onbroading_screen.dart';
import '../presentation/vehicle/screens/select_vehicle_type.dart';
import '../routes/route_names.dart';

import '../presentation/auth/screens/login_screen.dart';
import '../presentation/auth/screens/otp_screen.dart';

import '../presentation/navigation/bottom_nav_screen.dart';

import '../presentation/settings/screens/settings_screen.dart';

import '../presentation/splash/screens/splash_screen.dart';

import '../presentation/vehicle/screens/add_vehicle_screen.dart';
import '../presentation/vehicle/screens/vehicle_list_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.splash,

  routes: [
    /// SPLASH
    GoRoute(
      path: RouteNames.splash,

      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: RouteNames.onboarding,

      builder: (context, state) => const OnboardingScreen(),
    ),

    /// LOGIN
    GoRoute(
      path: RouteNames.login,

      builder: (context, state) => const LoginScreen(),
    ),

    /// OTP
    GoRoute(
      path: RouteNames.otp,

      builder: (context, state) => const OtpScreen(),
    ),

    /// HOME
    GoRoute(
      path: RouteNames.home,

      builder: (context, state) => const BottomNavScreen(),
    ),

    /// VEHICLE LIST
    GoRoute(
      path: RouteNames.vehicles,

      builder: (context, state) => const VehicleListScreen(),
    ),

    /// ADD VEHICLE
    GoRoute(
      path: RouteNames.addVehicle,

      builder: (context, state) => const AddVehicleScreen(),
    ),

    /// SETTINGS
    GoRoute(
      path: RouteNames.settings,

      builder: (context, state) => const SettingsScreen(),
    ),

    GoRoute(
      path: RouteNames.selectVehicleType,
      builder: (context, state) => const SelectVehicleTypeScreen(),
    ),
  ],
);

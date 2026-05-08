import 'package:flutter/material.dart';
import 'package:task_tejas/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../home/screens/home_screen.dart';
import '../services/screens/active_services_screen.dart';
import '../settings/screens/settings_screen.dart';
import '../vehicle/screens/vehicle_list_screen.dart';
import 'provider/navigation_provider.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NavigationProvider>();

    final screens = [
      const HomeScreen(),

      const ActiveServicesScreen(),

      const VehicleListScreen(),

      const SettingsScreen(),
    ];

    return Scaffold(
      body: screens[provider.currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.currentIndex,

        onTap: provider.changeIndex,

        type: BottomNavigationBarType.fixed,

        selectedFontSize: 12,

        unselectedFontSize: 12,

        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),

            label: AppLocalizations.of(context)!.home,
          ),

          BottomNavigationBarItem(
            icon: const Icon(Icons.miscellaneous_services),

            label: AppLocalizations.of(context)!.services,
          ),

          BottomNavigationBarItem(
            icon: const Icon(Icons.directions_car),

            label: AppLocalizations.of(context)!.vehicles,
          ),

          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),

            label: AppLocalizations.of(context)!.settings,
          ),
        ],
      ),
    );
  }
}

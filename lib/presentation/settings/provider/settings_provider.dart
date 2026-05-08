import 'package:flutter/material.dart';

import '../../../core/services/localization_service.dart';
import '../../../core/services/secure_storage_service.dart';

class SettingsProvider extends ChangeNotifier {
  final LocalizationService localizationService;

  final SecureStorageService secureStorageService;

  SettingsProvider({
    required this.localizationService,

    required this.secureStorageService,
  });

  Future<void> changeLanguage(String languageCode) async {
    await localizationService.changeLocale(languageCode);

    notifyListeners();
  }

  Future<void> logout() async {
    await secureStorageService.clear();

    notifyListeners();
  }
}

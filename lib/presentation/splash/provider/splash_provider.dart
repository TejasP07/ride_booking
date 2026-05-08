import 'package:flutter/material.dart';
import '../../../core/services/secure_storage_service.dart';

class SplashProvider extends ChangeNotifier {
  final SecureStorageService secureStorageService;

  SplashProvider({required this.secureStorageService});

  Future<bool> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await secureStorageService.getToken();

    if (token != null && token.isNotEmpty) {
      return true;
    }

    return false;
  }

  Future<bool> checkOnboardingStatus() async {
    return await secureStorageService.isOnboardingDone();
  }
}

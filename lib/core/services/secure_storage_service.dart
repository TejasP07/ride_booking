import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await storage.write(key: "access_token", value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: "access_token");
  }

  Future<void> clear() async {
    await storage.deleteAll();
  }

  Future<void> saveRefreshToken(String token) async {
    await storage.write(key: 'refresh_token', value: token);
  }

  Future<String?> getRefreshToken() async {
    return storage.read(key: 'refresh_token');
  }

  Future<void> saveOnboardingDone() async {
    await storage.write(key: "onboarding_done", value: "true");
  }

  Future<bool> isOnboardingDone() async {
    final value = await storage.read(key: "onboarding_done");

    return value == "true";
  }
}

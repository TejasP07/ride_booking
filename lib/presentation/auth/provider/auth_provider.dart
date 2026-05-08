import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/services/secure_storage_service.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/auth/request_otp_usecase.dart';

import '../../../domain/usecases/auth/verify_otp_usecase.dart';

class AuthProvider extends ChangeNotifier {
  UserEntity? currentUser;
  // UserEntity? user;

  String errorMessage = "";
  final RequestOtpUseCase requestOtpUseCase;

  final VerifyOtpUseCase verifyOtpUseCase;
  final SecureStorageService secureStorageService;

  AuthProvider({
    required this.requestOtpUseCase,

    required this.verifyOtpUseCase,

    required this.secureStorageService,
  });

  bool isLoading = false;

  String mobile = "";

  Future<bool> requestOtp({required String mobileNumber}) async {
    try {
      isLoading = true;

      errorMessage = "";

      notifyListeners();

      mobile = mobileNumber;

      await requestOtpUseCase(mobileNumber);

      return true;
    } catch (e) {
      if (e is DioException) {
        errorMessage =
            e.response?.data?["message"]?.toString() ?? "Something went wrong";
      } else {
        errorMessage = "Something went wrong";
      }

      return false;
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  Future<bool> verifyOtp({required String otp}) async {
    try {
      isLoading = true;
      String errorMessage = "";
      notifyListeners();

      final user = await verifyOtpUseCase(mobile: mobile, otp: otp);

      // await secureStorageService.saveToken(user.accessToken);

      await secureStorageService.saveToken(user.accessToken);

      await secureStorageService.saveRefreshToken(user.refreshToken);

      currentUser = user;
      currentUser = user;

      return true;
    } catch (e) {
      if (e is DioException) {
        errorMessage =
            e.response?.data?["message"]?.toString() ?? "Invalid OTP";
      } else {
        errorMessage = "Invalid OTP";
      }

      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

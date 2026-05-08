import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<void> requestOtp(String mobile);

  Future<UserEntity> verifyOtp({required String mobile, required String otp});
}

import '../../entities/user_entity.dart';

import '../../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<UserEntity> call({required String mobile, required String otp}) {
    return repository.verifyOtp(mobile: mobile, otp: otp);
  }
}

import '../../repositories/auth_repository.dart';

class RequestOtpUseCase {
  final AuthRepository repository;

  RequestOtpUseCase(this.repository);

  Future<void> call(String mobile) {
    return repository.requestOtp(mobile);
  }
}

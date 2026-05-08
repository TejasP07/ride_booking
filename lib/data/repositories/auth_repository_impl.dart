import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';
import '../mapper/user_mapper.dart';
import '../models/auth/auth_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> requestOtp(String mobile) async {
    await remoteDataSource.requestOtp(mobile: mobile);
  }

  @override
  Future<UserEntity> verifyOtp({
    required String mobile,

    required String otp,
  }) async {
    final response = await remoteDataSource.verifyOtp(mobile: mobile, otp: otp);

    final model = AuthResponseModel.fromJson(response.data);

    return UserMapper.toEntity(model);
  }
}

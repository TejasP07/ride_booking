import 'user_model.dart';

class AuthResponseModel {
  final String accessToken;

  final String refreshToken;

  final UserModel user;

  AuthResponseModel({
    required this.accessToken,

    required this.refreshToken,

    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return AuthResponseModel(
      accessToken: data['accessToken'] ?? '',

      refreshToken: data['refreshToken'] ?? '',

      user: UserModel.fromJson(data['user']),
    );
  }
}

import 'address_entity.dart';

class UserEntity {
  final String accessToken;

  final String refreshToken;

  final String id;

  final String fullName;

  final String email;

  final String mobile;

  final String profilePhoto;

  final bool isActive;

  final bool isProfileSetup;

  final List<AddressEntity> addresses;

  const UserEntity({
    required this.accessToken,

    required this.refreshToken,

    required this.id,

    required this.fullName,

    required this.email,

    required this.mobile,

    required this.profilePhoto,

    required this.isActive,

    required this.isProfileSetup,

    required this.addresses,
  });
}

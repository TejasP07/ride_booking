import 'address_model.dart';

class UserModel {
  final String id;

  final String fullName;

  final String email;

  final String mobile;

  final String profilePhoto;

  final bool isActive;

  final bool isProfileSetup;

  final List<AddressModel> addresses;

  UserModel({
    required this.id,

    required this.fullName,

    required this.email,

    required this.mobile,

    required this.profilePhoto,

    required this.isActive,

    required this.isProfileSetup,

    required this.addresses,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',

      fullName: json['full_name'] ?? '',

      email: json['email'] ?? '',

      mobile: json['mobile'] ?? '',

      profilePhoto: json['profile_photo'] ?? '',

      isActive: json['is_active'] ?? false,

      isProfileSetup: json['is_profile_setup'] ?? false,

      addresses:
          (json['addresses'] as List? ?? [])
              .map((e) => AddressModel.fromJson(e))
              .toList(),
    );
  }
}

import '../../domain/entities/address_entity.dart';

import '../../domain/entities/user_entity.dart';

import '../models/auth/address_model.dart';

import '../models/auth/auth_response_model.dart';

class UserMapper {
  static UserEntity toEntity(AuthResponseModel model) {
    return UserEntity(
      accessToken: model.accessToken,

      refreshToken: model.refreshToken,

      id: model.user.id,

      fullName: model.user.fullName,

      email: model.user.email,

      mobile: model.user.mobile,

      profilePhoto: model.user.profilePhoto,

      isActive: model.user.isActive,

      isProfileSetup: model.user.isProfileSetup,

      addresses: model.user.addresses.map(_mapAddress).toList(),
    );
  }

  static AddressEntity _mapAddress(AddressModel model) {
    return AddressEntity(
      id: model.id,

      label: model.label,

      city: model.city,

      pincode: model.pincode,

      fullAddress: model.fullAddress,

      isDefault: model.isDefault,
    );
  }
}

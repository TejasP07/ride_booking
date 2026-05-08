class AddressModel {
  final String id;

  final String label;

  final String city;

  final String pincode;

  final String fullAddress;

  final bool isDefault;

  AddressModel({
    required this.id,

    required this.label,

    required this.city,

    required this.pincode,

    required this.fullAddress,

    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'] ?? '',

      label: json['label'] ?? '',

      city: json['city'] ?? '',

      pincode: json['pincode'] ?? '',

      fullAddress: json['full_address'] ?? '',

      isDefault: json['isDefault'] ?? false,
    );
  }
}

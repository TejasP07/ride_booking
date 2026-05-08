class AddressEntity {
  final String id;

  final String label;

  final String city;

  final String pincode;

  final String fullAddress;

  final bool isDefault;

  const AddressEntity({
    required this.id,

    required this.label,

    required this.city,

    required this.pincode,

    required this.fullAddress,

    required this.isDefault,
  });
}

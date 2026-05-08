class ActiveServiceEntity {
  final String id;

  final String category;

  final String serviceTitle;

  final String serviceDescription;

  final List<String> serviceImages;

  final List<String> inclusions;

  final int price;

  final int totalAmount;

  final String duration;

  final bool isVehicle;

  const ActiveServiceEntity({
    required this.id,

    required this.category,

    required this.serviceTitle,

    required this.serviceDescription,

    required this.serviceImages,

    required this.inclusions,

    required this.price,

    required this.totalAmount,

    required this.duration,

    required this.isVehicle,
  });
}

import 'service_feature_model.dart';

class ServiceModel {
  final String id;

  final String category;

  final String serviceTitle;

  final String serviceDescription;

  final List<ServiceFeatureModel> features;

  final List<String> serviceImages;

  final List<String> inclusions;

  final List<String> beforeImages;

  final List<String> afterImages;

  final List<String> howServiceWorks;

  final int price;

  final int totalAmount;

  final int tax;

  final String duration;

  final bool isVehicle;

  ServiceModel({
    required this.id,

    required this.category,

    required this.serviceTitle,

    required this.serviceDescription,

    required this.features,

    required this.serviceImages,

    required this.inclusions,

    required this.beforeImages,

    required this.afterImages,

    required this.howServiceWorks,

    required this.price,

    required this.totalAmount,

    required this.tax,

    required this.duration,

    required this.isVehicle,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'] ?? '',

      category: json['category']?['title'] ?? '',

      serviceTitle: json['serviceTitle'] ?? '',

      serviceDescription: json['serviceDescription'] ?? '',

      features:
          (json['serviceFeature'] as List? ?? [])
              .map((e) => ServiceFeatureModel.fromJson(e))
              .toList(),

      serviceImages: List<String>.from(json['serviceImages'] ?? []),

      inclusions: List<String>.from(json['serviceInclusions'] ?? []),

      beforeImages: List<String>.from(json['serviceBefore'] ?? []),

      afterImages: List<String>.from(json['serviceAfter'] ?? []),

      howServiceWorks: List<String>.from(json['howServiceWorks'] ?? []),

      price: json['price'] ?? 0,

      totalAmount: json['totalAmount'] ?? 0,

      tax: json['tax'] ?? 0,

      duration: json['duration'] ?? '',

      isVehicle: json['isVehicle'] ?? false,
    );
  }
}

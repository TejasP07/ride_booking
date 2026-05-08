class ServiceFeatureModel {
  final String title;

  final String? icon;

  ServiceFeatureModel({required this.title, this.icon});

  factory ServiceFeatureModel.fromJson(Map<String, dynamic> json) {
    return ServiceFeatureModel(title: json['title'] ?? '', icon: json['icon']);
  }
}

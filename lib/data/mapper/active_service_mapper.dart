import '../../domain/entities/service_entity.dart';

import '../models/service/service_model.dart';

class ActiveServiceMapper {
  static ActiveServiceEntity toEntity(Map<String, dynamic> json) {
    final model = ServiceModel.fromJson(json);

    return ActiveServiceEntity(
      id: model.id,

      category: model.category,

      serviceTitle: model.serviceTitle,

      serviceDescription: model.serviceDescription,

      serviceImages: model.serviceImages,

      inclusions: model.inclusions,

      price: model.price,

      totalAmount: model.totalAmount,

      duration: model.duration,

      isVehicle: model.isVehicle,
    );
  }
}

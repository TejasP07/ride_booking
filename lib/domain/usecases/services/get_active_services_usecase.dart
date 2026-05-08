import '../../entities/service_entity.dart';
import '../../repositories/service_repository.dart';

class GetActiveServicesUseCase {
  final ServiceRepository repository;

  GetActiveServicesUseCase(this.repository);

  Future<List<ActiveServiceEntity>> call() {
    return repository.getActiveServices();
  }
}

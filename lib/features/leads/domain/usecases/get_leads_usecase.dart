import '../../models/lead_model.dart';
import '../repository/leads_repository.dart';

class GetLeadsUseCase {
  final LeadsRepository repository;
  GetLeadsUseCase(this.repository);

  Future<List<LeadModel>> call() async {
    return await repository.getLeads();
  }
}

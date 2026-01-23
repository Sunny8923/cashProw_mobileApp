import '../../models/lead_model.dart';

abstract class LeadsRepository {
  Future<List<LeadModel>> getLeads();
}

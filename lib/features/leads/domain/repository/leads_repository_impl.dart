import 'package:cash_prow/features/leads/data/datasources/leads_remote_data_source.dart';
import '../../domain/repository/leads_repository.dart';
import '../../models/lead_model.dart';

class LeadsRepositoryImpl implements LeadsRepository {
  final LeadsRemoteDataSource remoteDataSource;

  LeadsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<LeadModel>> getLeads() async {
    return await remoteDataSource.getLeads();
  }
}

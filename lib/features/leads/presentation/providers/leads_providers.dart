import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/leads_remote_data_source.dart';
import '../../domain/repository/leads_repository_impl.dart';
import '../../domain/repository/leads_repository.dart';
import '../../domain/usecases/get_leads_usecase.dart';

final leadsRemoteDataSourceProvider = Provider<LeadsRemoteDataSource>((ref) {
  return LeadsRemoteDataSourceImpl(ref.read(apiClientProvider));
});

final leadsRepositoryProvider = Provider<LeadsRepository>((ref) {
  return LeadsRepositoryImpl(ref.read(leadsRemoteDataSourceProvider));
});

final getLeadsUseCaseProvider = Provider<GetLeadsUseCase>((ref) {
  return GetLeadsUseCase(ref.read(leadsRepositoryProvider));
});

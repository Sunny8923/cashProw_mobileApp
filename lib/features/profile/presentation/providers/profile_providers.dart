import 'package:cash_prow/features/auth/presentation/providers/auth_providers.dart';
import 'package:cash_prow/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>((
  ref,
) {
  final apiClient = ref.read(apiClientProvider);
  return ProfileRemoteDataSourceImpl(apiClient);
});

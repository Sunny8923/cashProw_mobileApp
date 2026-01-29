import 'package:cash_prow/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart'; // wherever apiClientProvider is

class LeadsRemoteDataSource {
  final ApiClient _api;

  LeadsRemoteDataSource(this._api);

  Future<void> createLead({
    required String name,
    required String product,
    required String phone,
    required String location,
  }) async {
    await _api.post(
      "/api/leads",
      data: {
        "type": "Referral",
        "name": name,
        "product": product,
        "contactPhone": phone,
        "location": location,
      },
    );
  }
}

final leadsRemoteProvider = Provider<LeadsRemoteDataSource>((ref) {
  final api = ref.read(apiClientProvider);
  return LeadsRemoteDataSource(api);
});

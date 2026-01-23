import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../models/lead_model.dart';

abstract class LeadsRemoteDataSource {
  Future<List<LeadModel>> getLeads();
}

class LeadsRemoteDataSourceImpl implements LeadsRemoteDataSource {
  final ApiClient apiClient;

  LeadsRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<LeadModel>> getLeads() async {
    try {
      final response = await apiClient.get(ApiEndpoints.leads);
      final data = response.data;

      if (data is Map<String, dynamic>) {
        final leads = data["data"]; // ✅ FIXED

        if (leads is List) {
          return leads
              .whereType<Map<String, dynamic>>()
              .map((e) => LeadModel.fromJson(e))
              .toList();
        }
      }

      throw Exception("Invalid leads response format");
    } on DioException catch (e) {
      final backendMsg = e.response?.data;
      if (backendMsg is Map<String, dynamic>) {
        throw Exception(backendMsg["message"] ?? "Failed to load leads");
      }
      throw Exception("Failed to load leads");
    }
  }
}

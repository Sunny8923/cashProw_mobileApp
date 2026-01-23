import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<UserModel> me();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.login,
        data: request.toJson(),
      );

      final data = response.data;

      if (data is Map<String, dynamic>) {
        return LoginResponseModel.fromJson(data);
      }
      throw Exception("Invalid login response format");
    } on DioException catch (e) {
      final backendMsg = e.response?.data;
      if (backendMsg is Map<String, dynamic>) {
        throw Exception(backendMsg["message"] ?? "Login failed");
      }
      throw Exception("Network error: ${e.message}");
    }
  }

  @override
  Future<UserModel> me() async {
    try {
      final response = await apiClient.get(ApiEndpoints.me);
      final data = response.data;

      if (data is Map<String, dynamic>) {
        final user = data["data"]; // ✅ FIXED
        if (user is Map<String, dynamic>) {
          return UserModel.fromJson(user);
        }
      }

      throw Exception("Invalid /me response format");
    } on DioException {
      throw Exception("Session expired. Please login again.");
    }
  }
}

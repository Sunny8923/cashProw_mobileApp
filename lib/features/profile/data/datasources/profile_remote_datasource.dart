import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';

abstract class ProfileRemoteDataSource {
  Future<String> uploadProfilePicture(String filePath);

  Future<void> updateProfile({
    String? address,
    String? occupation,
    double? salary,
  });

  // 👉 EMAIL CHANGE OTP
  Future<void> requestChangeEmail(String newEmail);
  Future<void> verifyChangeEmail({
    required String newEmail,
    required String otp,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient apiClient;
  ProfileRemoteDataSourceImpl(this.apiClient);

  @override
  Future<String> uploadProfilePicture(String filePath) async {
    try {
      final formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(filePath),
      });

      final response = await apiClient.post(
        ApiEndpoints.uploadProfilePic,
        data: formData,
        options: Options(contentType: "multipart/form-data"),
      );

      final payload = response.data["data"];
      return payload["profileImageUrl"];
    } catch (e) {
      throw Exception("Upload failed");
    }
  }

  @override
  Future<void> updateProfile({
    String? address,
    String? occupation,
    double? salary,
  }) async {
    final body = <String, dynamic>{};

    if (address != null) body["address"] = address;
    if (occupation != null) body["occupation"] = occupation;
    if (salary != null) body["salary"] = salary;

    await apiClient.patch(ApiEndpoints.updateProfile, data: body);
  }

  // ---------------- EMAIL OTP ----------------

  @override
  Future<void> requestChangeEmail(String newEmail) async {
    await apiClient.post(
      ApiEndpoints.requestChangeEmail,
      data: {"newEmail": newEmail},
    );
  }

  @override
  Future<void> verifyChangeEmail({
    required String newEmail,
    required String otp,
  }) async {
    await apiClient.post(
      ApiEndpoints.verifyChangeEmail,
      data: {"newEmail": newEmail, "otp": otp},
    );
  }
}

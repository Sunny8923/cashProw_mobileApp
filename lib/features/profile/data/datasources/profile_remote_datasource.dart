import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';

abstract class ProfileRemoteDataSource {
  Future<String> uploadProfilePicture(String filePath);
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

      final data = response.data;

      if (data is Map<String, dynamic>) {
        final payload = data["data"];
        if (payload is Map<String, dynamic>) {
          final url = payload["profileImageUrl"];
          if (url is String) return url;
        }
      }

      throw Exception("Invalid upload response format");
    } on DioException catch (e) {
      final backend = e.response?.data;
      if (backend is Map<String, dynamic>) {
        throw Exception(backend["message"] ?? "Upload failed");
      }
      throw Exception("Upload failed");
    }
  }
}

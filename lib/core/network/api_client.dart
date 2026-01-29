import 'package:dio/dio.dart';
import '../storage/token_storage.dart';
import 'api_endpoints.dart';

class ApiClient {
  late final Dio dio;

  ApiClient(TokenStorage tokenStorage) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {"Content-Type": "application/json"},
      ),
    );

    // ✅ Add token automatically in every request
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await tokenStorage.getToken();

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },

        // ✅ Optional: handle errors globally (nice for debugging)
        onError: (DioException e, handler) {
          // You can add logging here later if needed
          return handler.next(e);
        },
      ),
    );
  }

  // -------- POST --------
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return await dio.post(
      path,
      data: data,
      queryParameters: query,
      options: options,
    );
  }

  // -------- GET --------
  Future<Response> get(
    String path, {
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return await dio.get(path, queryParameters: query, options: options);
  }

  // -------- PUT --------
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return await dio.put(
      path,
      data: data,
      queryParameters: query,
      options: options,
    );
  }

  // -------- PATCH --------
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return await dio.patch(
      path,
      data: data,
      queryParameters: query,
      options: options,
    );
  }
}

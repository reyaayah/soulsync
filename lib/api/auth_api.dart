import 'package:dio/dio.dart';
import 'package:soulsync/models/login_models.dart';

class AuthApi {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://127.0.0.1:8000"));

  Future<String> login(LoginRequest data) async {
    try {
      final response = await _dio.post("/auth/login", data: data.toJson());

      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        throw Exception('Failed to log in');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? "Login failed");
    }
  }
}

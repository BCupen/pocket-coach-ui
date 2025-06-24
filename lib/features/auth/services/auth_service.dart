import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocket_coach_ui/features/auth/services/dtos/login_request.dart';
import 'package:pocket_coach_ui/features/auth/services/dtos/login_response.dart';

class AuthService {
  late final Dio _dio;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final String baseUrl;
  late final String authUrl;

  AuthService()
    : baseUrl = dotenv.env["API_BASE_URL"] ?? "http://localhost:8080/" {
    authUrl = '$baseUrl/auth';
    _dio = Dio(
      BaseOptions(
        baseUrl: authUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  Future<String> login(String email, String password) async {
    try {
      LoginRequest loginRequest = LoginRequest(
        email: email,
        password: password,
      );
      final response = await _dio.post('/login', data: loginRequest.toJson());
      final loginData = LoginResponse.fromJson(response.data['data']);
      await _persistTokens(loginData.accessToken, loginData.refreshToken);
      return loginData.username;
    } on DioException catch (e) {
      // DioException holds the HTTP response info when available
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final data = e.response!.data;

        // Assuming your backend sends error message like { "message": "Invalid credentials" }
        final errorMessage = data['message'] ?? 'Unknown error occurred';

        print('Error status: $statusCode');
        print('Error message: $errorMessage');

        // You can throw or handle this however you want
        throw Exception('Error $statusCode: $errorMessage');
      } else {
        // No response from server (timeout, no connection, etc)
        print('No response received: ${e.message}');
        throw Exception('No response from server: ${e.message}');
      }
    } catch (e) {
      // Other errors (parsing issues, etc)
      print('Unexpected error: $e');
      throw Exception('Unexpected error occurred');
    }
  }

  Future<void> register(String email, String password, String username) async {
    // Todo: Implement registration logic
    return;
  }

  // Token Storage
  Future<void> _persistTokens(String accessToken, String refreshToken) async {
    await _secureStorage.write(key: 'accessToken', value: accessToken);
    await _secureStorage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<void> _clearTokens() async {
    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'refreshToken');
  }

  // Optional access for tokens
  Future<String?> getAccessToken() => _secureStorage.read(key: 'accessToken');
  Future<String?> getRefreshToken() => _secureStorage.read(key: 'refreshToken');
}

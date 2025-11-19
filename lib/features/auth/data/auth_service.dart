import '../../../core/network/api_client.dart';
import '../../../core/storage/token_storage.dart';
import 'auth_models.dart';

class AuthService {
  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;

  AuthService(this._apiClient, this._tokenStorage);

  /// Simulate OAuth2 login with credential validation
  Future<LoginResponse> login(String email, String password) async {
    try {
      // Simulating API call - replace with real endpoint
      await Future.delayed(const Duration(seconds: 1));

      // Demo credentials validation
      const validEmail = 'demo@example.com';
      const validPassword = 'password123';

      if (email != validEmail || password != validPassword) {
        throw Exception('Invalid credentials. Use: $validEmail / $validPassword');
      }

      // Mock response (since jsonplaceholder doesn't have auth)
      final response = LoginResponse(
        accessToken:
            'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken:
            'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        tokenType: 'Bearer',
        expiresIn: 3600,
      );

      // Save tokens
      await _tokenStorage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      return response;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> logout() async {
    await _tokenStorage.deleteTokens();
  }

  Future<bool> isLoggedIn() async {
    return await _tokenStorage.hasValidToken();
  }
}

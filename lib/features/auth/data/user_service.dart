import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import 'user_models.dart';

class UserService {
  final ApiClient _apiClient;

  UserService(this._apiClient);

  /// GET - Fetch all users (Microservice 1)
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _apiClient.dio.get('/users');
      final List<dynamic> data = response.data;
      return data.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  /// GET - Fetch single user
  Future<UserModel> getUserById(int id) async {
    try {
      final response = await _apiClient.dio.get('/users/$id');
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  /// POST - Create user
  Future<UserModel> createUser(UserModel user) async {
    try {
      final response = await _apiClient.dio.post(
        '/users',
        data: user.toJson(),
      );
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  /// PUT - Update user
  Future<UserModel> updateUser(int id, UserModel user) async {
    try {
      final response = await _apiClient.dio.put(
        '/users/$id',
        data: user.toJson(),
      );
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  /// DELETE - Delete user
  Future<void> deleteUser(int id) async {
    try {
      await _apiClient.dio.delete('/users/$id');
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}

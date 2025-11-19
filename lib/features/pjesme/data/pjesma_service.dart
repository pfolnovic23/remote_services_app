import '../../../core/network/api_client.dart';
import 'pjesma_models.dart';

class PjesmaService {
  final ApiClient _apiClient;

  PjesmaService(this._apiClient);

  /// GET - Fetch all songs
  Future<List<PjesmaModel>> getPjesme() async {
    try {
      final response = await _apiClient.dio.get('/pjesme');
      final List<dynamic> data = response.data;
      return data.map((json) => PjesmaModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load pjesme: $e');
    }
  }

  /// GET - Fetch single song by ID
  Future<PjesmaModel> getPjesmaById(int id) async {
    try {
      final response = await _apiClient.dio.get('/pjesme/$id');
      return PjesmaModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load pjesma: $e');
    }
  }
}

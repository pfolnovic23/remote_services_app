import '../../../core/network/api_client.dart';
import 'reper_models.dart';

class ReperService {
  final ApiClient _apiClient;

  ReperService(this._apiClient);

  /// GET - Fetch all rappers
  Future<List<ReperModel>> getReperi() async {
    try {
      final response = await _apiClient.dio.get('/reperi');
      final List<dynamic> data = response.data;
      return data.map((json) => ReperModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load reperi: $e');
    }
  }

  /// GET - Fetch single rapper by ID
  Future<ReperModel> getReperById(int id) async {
    try {
      final response =
          await _apiClient.dio.get('/reperi', queryParameters: {'id': id});
      final List<dynamic> data = response.data;
      if (data.isEmpty) {
        throw Exception('Reper not found');
      }
      return ReperModel.fromJson(data.first);
    } catch (e) {
      throw Exception('Failed to load reper: $e');
    }
  }
}

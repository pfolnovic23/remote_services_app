import '../../../core/network/api_client.dart';
import 'product_models.dart';

class ProductService {
  final ApiClient _apiClient;

  ProductService(this._apiClient);

  /// GET - Fetch all products (Microservice 2)
  /// Using /posts endpoint as product example
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _apiClient.dio.get('/posts');
      final List<dynamic> data = response.data;
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  /// GET - Fetch single product
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _apiClient.dio.get('/posts/$id');
      return ProductModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }

  /// POST - Create product
  Future<ProductModel> createProduct(ProductModel product) async {
    try {
      final response = await _apiClient.dio.post(
        '/posts',
        data: product.toJson(),
      );
      return ProductModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create product: $e');
    }
  }

  /// PUT - Update product
  Future<ProductModel> updateProduct(int id, ProductModel product) async {
    try {
      final response = await _apiClient.dio.put(
        '/posts/$id',
        data: product.toJson(),
      );
      return ProductModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  /// DELETE - Delete product
  Future<void> deleteProduct(int id) async {
    try {
      await _apiClient.dio.delete('/posts/$id');
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
}

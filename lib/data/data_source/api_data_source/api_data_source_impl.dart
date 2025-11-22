import 'package:news_app/data/api/api_client.dart';
import 'package:news_app/data/api/dio_provider.dart';
import 'package:news_app/data/data_source/api_data_source/api_data_source.dart';
import 'package:news_app/data/models/articles/source.dart';

class ApiDataSourceImpl implements ApiDataSource {
  final ApiClient _apiClient = ApiClient(providerDio());

  @override
  Future<List<Sources>> getArticles(String category) async {
    try {
      var response = await _apiClient.getArticles(category);
      return response?.sources ?? [];
    } catch (e) {
      rethrow;
    }
  }
}

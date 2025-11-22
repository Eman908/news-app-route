import 'package:news_app/data/models/articles/source.dart';

abstract interface class ApiDataSource {
  Future<List<Sources>?> getArticles(String category);
}

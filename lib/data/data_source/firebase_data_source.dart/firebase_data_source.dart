import 'package:news_app/data/models/articles/source.dart';

abstract interface class FirebaseDataSource {
  Future<List<Sources>> getSources(String categoryId);
  Future<void> setSources(List<Sources>? sources, String categoryId);
}

import 'package:news_app/data/models/articles/source.dart';

abstract interface class SourceRepo {
  Future<List<Sources>?> getAllSources(String category);
}

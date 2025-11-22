import 'package:news_app/data/models/articles/source.dart';
import 'package:news_app/domain/repository/source_repo.dart';

class UseCase {
  SourceRepo sourceRepo;
  UseCase(this.sourceRepo);
  Future<List<Sources>?> getAllSources(String category) {
    return sourceRepo.getAllSources(category);
  }
}

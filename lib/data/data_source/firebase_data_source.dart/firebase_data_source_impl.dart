import 'package:news_app/data/data_source/firebase_data_source.dart/firebase_data_source.dart';
import 'package:news_app/data/firebase/firebase_service.dart';
import 'package:news_app/data/models/articles/source.dart';

class FirebaseDataSourceImpl implements FirebaseDataSource {
  FirebaseService firebaseService = FirebaseService();
  @override
  Future<List<Sources>> getSources(String categoryId) async {
    try {
      return await firebaseService.getSource(categoryId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setSources(List<Sources>? sources, String categoryId) async {
    try {
      await firebaseService.setSource(sources, categoryId);
    } catch (e) {
      rethrow;
    }
  }
}

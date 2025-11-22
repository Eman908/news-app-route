import 'package:news_app/data/data_source/api_data_source/api_data_source.dart';
import 'package:news_app/data/data_source/firebase_data_source.dart/firebase_data_source.dart';
import 'package:news_app/data/models/articles/source.dart';
import 'package:news_app/domain/repository/source_repo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SourceRepoImpl implements SourceRepo {
  ApiDataSource apiDataSource;
  FirebaseDataSource firebaseDataSource;

  SourceRepoImpl(this.apiDataSource, this.firebaseDataSource);

  @override
  Future<List<Sources>> getAllSources(String category) async {
    try {
      var connected = await _isConnected();
      if (connected) {
        var sources = await apiDataSource.getArticles(category) ?? [];
        firebaseDataSource.setSources(sources, category);
        return sources;
      } else {
        return _getSourceFromFirebase(category);
      }
    } catch (e) {
      try {
        return _getSourceFromFirebase(category);
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<bool> _isConnected() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    return (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet));
  }

  Future<List<Sources>> _getSourceFromFirebase(categoryId) async {
    try {
      return firebaseDataSource.getSources(categoryId);
    } catch (e) {
      rethrow;
    }
  }
}

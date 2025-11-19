import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/api/api_client.dart';
import 'package:news_app/api/dio_provider.dart';
import 'package:news_app/models/articles/source.dart';
import 'package:news_app/models/full_atricles/article.dart';

class NewsTabProvider extends ChangeNotifier {
  final ApiClient data = ApiClient(providerDio());
  List<Source> article = [];
  List<Article> fullArticles = [];
  final int pageSize = 5;

  String? errMessage;
  String? errMessage2;
  bool loading = false;
  bool loading2 = false;
  int selected = 0;

  late PagingController<int, Article> pagingController;

  // Initialize method
  void initialize(String category) {
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) {
      getFullArticles(pageKey);
    });
    getArticles(category);
  }

  Future<void> getArticles(String category) async {
    loading = true;
    try {
      var response = await data.getArticles(category);
      if (response!.status == 'ok') {
        article = response.sources ?? [];
        errMessage = null;

        // Load first page after getting sources
        if (article.isNotEmpty) {
          pagingController.refresh();
        }
      } else {
        errMessage = 'Failed to load sources';
      }
    } catch (e) {
      errMessage = 'Error: $e';
    } finally {
      loading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void changeSelected(int index) {
    selected = index;
    // Refresh data when source changes
    pagingController.refresh();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> getFullArticles(int page) async {
    try {
      // Check if we have sources
      if (article.isEmpty || selected >= article.length) {
        pagingController.appendLastPage([]);
        return;
      }

      final sourceId = article[selected].id ?? '';

      if (sourceId.isEmpty) {
        pagingController.appendLastPage([]);
        return;
      }

      final response = await data.getFullArticles(
        sourceId,
        null,
        page.toString(),
        pageSize.toString(),
      );

      final newArticles = response?.articles ?? [];

      final isLastPage = newArticles.length < pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newArticles);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(newArticles, nextPageKey);
      }
    } catch (e) {
      pagingController.error = e;
    }
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}

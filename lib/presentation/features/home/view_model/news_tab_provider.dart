import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/core/base/base_view_model.dart';
import 'package:news_app/data/api/api_client.dart';
import 'package:news_app/data/api/dio_provider.dart';
import 'package:news_app/data/data_source/api_data_source/api_data_source_impl.dart';
import 'package:news_app/data/data_source/firebase_data_source.dart/firebase_data_source_impl.dart';
import 'package:news_app/data/models/articles/source.dart';
import 'package:news_app/data/models/full_atricles/article.dart';
import 'package:news_app/data/repository/source_repo_impl.dart';
import 'package:news_app/domain/usecase/use_case.dart';
import 'package:news_app/presentation/features/home/view_model/news_tab_navigator.dart';

class NewsTabProvider extends BaseViewModel<NewsTabNavigator> {
  final ApiClient data = ApiClient(providerDio());
  final UseCase repo = UseCase(
    SourceRepoImpl(ApiDataSourceImpl(), FirebaseDataSourceImpl()),
  );
  List<Sources> article = [];
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
      article = await repo.getAllSources(category) ?? [];

      await repo.getAllSources(category);
      if (article.isNotEmpty) {
        pagingController.refresh();
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

  void push(String route) {
    navigator?.push(route);
    notifyListeners();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}

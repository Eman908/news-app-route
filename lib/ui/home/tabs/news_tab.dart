import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/full_atricles/article.dart';
import 'package:news_app/ui/home/widgets/news_bottom_sheet.dart';
import 'package:news_app/ui/home/widgets/news_card.dart';

class NewsTab extends StatefulWidget {
  const NewsTab({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  int selected = 0;

  static const int pageSize = 5;

  late PagingController<int, Article> pagingController;

  @override
  void initState() {
    super.initState();

    pagingController = PagingController(firstPageKey: 1);

    pagingController.addPageRequestListener((pageKey) {
      loadArticlesPage(pageKey);
    });
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  Future<void> loadArticlesPage(int page) async {
    try {
      final sourceId = sources[selected].id ?? '';

      final data = await ApiManager().getFullArticles(
        source: sourceId,
        page: page.toString(),
        pageSize: pageSize.toString(),
      );

      final newItems = data?.articles ?? [];

      final isLastPage = newItems.length < pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (e) {
      pagingController.error = e;
    }
    log("Loading page: $page");
  }

  List sources = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager().getArticles(category: widget.categoryModel.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        } else if (snapshot.hasError) {
          return const Center(child: Icon(Icons.error));
        } else if (snapshot.hasData) {
          sources = snapshot.data?.sources ?? [];

          return Column(
            children: [
              DefaultTabController(
                length: sources.length,
                child: TabBar(
                  onTap: (index) {
                    setState(() {
                      selected = index;
                    });

                    pagingController.refresh();
                  },
                  labelStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: const TextStyle(fontSize: 16),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: const EdgeInsets.all(8),
                  padding: EdgeInsets.zero,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  tabs:
                      sources
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                e.name ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),

              Expanded(
                child: PagedListView<int, Article>.separated(
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  pagingController: pagingController,
                  padding: const EdgeInsets.all(16),
                  builderDelegate: PagedChildBuilderDelegate<Article>(
                    itemBuilder:
                        (context, article, index) => InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (_) => NewsBottomSheet(article: article),
                            );
                          },
                          child: NewsCard(article: article),
                        ),
                    firstPageProgressIndicatorBuilder:
                        (_) => const Center(child: CircularProgressIndicator()),
                    newPageProgressIndicatorBuilder:
                        (_) => const Center(child: CircularProgressIndicator()),
                    noItemsFoundIndicatorBuilder:
                        (_) => const Center(child: Text("No Articles Found")),
                    firstPageErrorIndicatorBuilder:
                        (_) => const Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

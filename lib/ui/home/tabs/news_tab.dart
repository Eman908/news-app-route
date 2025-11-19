import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/full_atricles/article.dart';
import 'package:news_app/providers/news_tab_provider.dart';
import 'package:news_app/ui/home/widgets/news_bottom_sheet.dart';
import 'package:news_app/ui/home/widgets/news_card.dart';
import 'package:provider/provider.dart';

class NewsTab extends StatelessWidget {
  const NewsTab({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsTabProvider()..initialize(categoryModel.id),
      child: Consumer<NewsTabProvider>(
        builder: (context, tabProvider, child) {
          return Column(
            children: [
              if (tabProvider.loading)
                const LinearProgressIndicator()
              else if (tabProvider.errMessage != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Icon(Icons.error, size: 40),
                      Text('Error: ${tabProvider.errMessage}'),
                    ],
                  ),
                )
              else if (tabProvider.article.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No sources found'),
                )
              else
                DefaultTabController(
                  length: tabProvider.article.length,
                  child: TabBar(
                    onTap: (index) {
                      tabProvider.changeSelected(index);
                    },
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: const TextStyle(fontSize: 14),
                    indicatorSize: TabBarIndicatorSize.label,
                    padding: EdgeInsets.zero,
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    tabs:
                        tabProvider.article
                            .map(
                              (e) => Text(
                                e.name ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),

              Expanded(
                child: PagedListView<int, Article>.separated(
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  pagingController: tabProvider.pagingController,
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
        },
      ),
    );
  }
}

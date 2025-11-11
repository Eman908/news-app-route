import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/models/category_model.dart';
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
          var sources = snapshot.data?.sources ?? [];
          return Column(
            children: [
              DefaultTabController(
                initialIndex: selected,

                length: sources.length,
                child: TabBar(
                  onTap: (index) {
                    selected = index;
                    setState(() {});
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
                  tabs: sources.map((e) => Text(e.name ?? '')).toList(),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: ApiManager().getFullArticles(
                    source: sources[selected].id ?? '',
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Icon(Icons.error));
                    } else if (snapshot.hasData) {
                      var articles = snapshot.data?.articles ?? [];
                      return ListView.separated(
                        padding: const EdgeInsets.all(16),
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 16),
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          return InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder:
                                    (context) =>
                                        NewsBottomSheet(article: article),
                              );
                            },
                            child: NewsCard(article: article),
                          );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
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

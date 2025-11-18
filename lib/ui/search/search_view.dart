import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/core/extensions/context_extension.dart';
import 'package:news_app/core/extensions/padding_extension.dart';
import 'package:news_app/providers/search_provider.dart';
import 'package:news_app/ui/home/widgets/news_bottom_sheet.dart';
import 'package:news_app/ui/home/widgets/news_card.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchProvider(),
      builder: (context, child) {
        var provider = Provider.of<SearchProvider>(context);
        return Scaffold(
          body: SafeArea(
            child: Column(
              spacing: 16,
              children: [
                TextField(
                  controller: provider.input,
                  onChanged: (value) {
                    provider.getSearchResult(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: context.colors.secondary),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    hintText: context.local.search,
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: ApiManager().getFullArticles(
                      param: provider.search.isEmpty ? null : provider.search,
                      page: "1",
                      pageSize: "20",
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Icon(Icons.error));
                      } else if (snapshot.hasData) {
                        var articles = snapshot.data?.articles ?? [];
                        List filtered =
                            articles.where((e) {
                              final search = provider.search.toLowerCase();

                              final description =
                                  e.description?.toLowerCase() ?? '';
                              final content = e.content?.toLowerCase() ?? '';
                              final title = e.title?.toLowerCase() ?? '';
                              final author = e.author?.toLowerCase() ?? '';

                              return description.contains(search) ||
                                  content.contains(search) ||
                                  title.contains(search) ||
                                  author.contains(search);
                            }).toList();

                        return ListView.separated(
                          separatorBuilder:
                              (context, index) => const SizedBox(height: 16),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final article = filtered[index];
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
            ).symmetricPadding(horizontal: 16, vertical: 24),
          ),
        );
      },
    );
  }
}

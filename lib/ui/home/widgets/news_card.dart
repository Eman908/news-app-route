import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/extensions/context_extension.dart';
import 'package:news_app/models/full_atricles/article.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.article});
  final Article article;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.secondary),
      ),
      child: Column(
        spacing: 16,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(article.urlToImage ?? ''),
          ),
          Text(
            article.title ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.text.bodyLarge!.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  child: Text(
                    "By: ${article.author ?? ""}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                child: Text(
                  DateFormat.yMMMEd().add_jm().format(
                    DateTime.parse(article.publishedAt ?? ""),
                  ),

                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

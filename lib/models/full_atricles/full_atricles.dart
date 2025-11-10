import 'article.dart';

class FullAtricles {
  String? status;
  int? totalResults;
  List<Article>? articles;

  FullAtricles({this.status, this.totalResults, this.articles});

  factory FullAtricles.fromJson(Map<String, dynamic> json) => FullAtricles(
    status: json['status'] as String?,
    totalResults: json['totalResults'] as int?,
    articles:
        (json['articles'] as List<dynamic>?)
            ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'totalResults': totalResults,
    'articles': articles?.map((e) => e.toJson()).toList(),
  };
}

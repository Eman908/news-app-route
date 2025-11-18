import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/models/articles/articles.dart';
import 'package:news_app/models/full_atricles/full_atricles.dart';

class ApiManager {
  final String baseUrl = "newsapi.org";
  final String apiKey = dotenv.env['APIKEY']!;
  final String endPoint = '/v2/top-headlines/sources';
  final String endPoint2 = '/v2/everything';
  final Dio dio = Dio();

  Future<Articles?> getArticles({required String category}) async {
    Uri uri = Uri.https(baseUrl, endPoint, {"category": category});
    Response response = await dio.getUri(
      uri,
      options: Options(headers: {"Authorization": apiKey}),
    );
    var data = Articles.fromJson(response.data);
    return data;
  }

  Future<FullAtricles?> getFullArticles({
    String? source,
    String? param,
    String? page,
    String? pageSize,
  }) async {
    Uri uri = Uri.https(baseUrl, endPoint2, {
      "sources": source,
      "q": param,
      "page": page,
      "pageSize": pageSize,
    });
    Response response = await dio.getUri(
      uri,
      options: Options(headers: {"Authorization": apiKey}),
    );
    var data = FullAtricles.fromJson(response.data);

    return data;
  }
}

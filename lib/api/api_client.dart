import 'package:dio/dio.dart';
import 'package:news_app/models/articles/articles.dart';
import 'package:news_app/models/full_atricles/full_atricles.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://newsapi.org")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  //tabbar
  @GET('/v2/top-headlines/sources')
  Future<Articles?> getArticles(@Query('category') String category);

  @GET('/v2/everything')
  Future<FullAtricles?> getFullArticles(
    @Query('sources') String? source,
    @Query('q') String? param,
    @Query('page') String? page,
    @Query('pageSize') String? pageSize,
  );
}

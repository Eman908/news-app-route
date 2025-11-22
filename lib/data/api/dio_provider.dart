import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio providerDio() {
  Dio dio = Dio();
  dio.options.headers = {'Authorization': dotenv.env['APIKEY']};
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 140,
      enabled: kDebugMode,
    ),
  );
  return dio;
}

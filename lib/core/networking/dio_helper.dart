import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  DioHelper._();

  static const String baseUrl = 'https://app.ticketmaster.com/discovery/v2/';
  static const String apiKey = 'A0rzBE75musPJcXPxIAHJSnXFhCPboxE';

  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 15),
        responseType: ResponseType.plain,
        headers: const {'Accept': 'application/json'},
        queryParameters: const {'apikey': apiKey},
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: false,
          requestBody: false,
          responseHeader: false,
          responseBody: true,
          compact: true,
        ),
      );
    }

    return dio;
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppFailure implements Exception {
  const AppFailure(this.message);

  final String message;

  factory AppFailure.fromException(Object error) {
    if (error is AppFailure) return error;

    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return const AppFailure('The request timed out. Please try again.');
      }

      if (error.type == DioExceptionType.connectionError) {
        return const AppFailure(
          'No internet connection. Check your network and retry.',
        );
      }

      final responseData = error.response?.data;
      final data = responseData is String
          ? _decodeResponse(responseData)
          : responseData;
      if (data is Map<String, dynamic>) {
        final fault = data['fault'];
        if (fault is Map<String, dynamic>) {
          final message = fault['faultstring'];
          if (message is String && message.isNotEmpty) {
            return AppFailure(message);
          }
        }
      }

      final statusCode = error.response?.statusCode;
      if (statusCode == 401 || statusCode == 403) {
        return const AppFailure('The Ticketmaster API key is not authorized.');
      }
      if (statusCode != null && statusCode >= 500) {
        return const AppFailure(
          'Ticketmaster is unavailable. Please try again later.',
        );
      }
    }

    if (kDebugMode) {
      return AppFailure('Unexpected error: $error');
    }
    return const AppFailure('Something went wrong. Please try again.');
  }

  @override
  String toString() => message;

  static Object? _decodeResponse(String value) {
    try {
      return jsonDecode(value);
    } on FormatException {
      return value;
    }
  }
}

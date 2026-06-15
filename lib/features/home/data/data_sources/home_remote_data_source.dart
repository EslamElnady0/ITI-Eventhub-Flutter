import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/networking/ticketmaster_date_time.dart';
import '../../../../core/utils/isolate_parser.dart';
import '../models/home_classification_dto.dart';
import '../models/home_event_dto.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeClassificationDto>> getClassifications();

  Future<List<HomeEventDto>> getUpcomingEvents({
    required String city,
    required DateTime startDateTime,
  });

  Future<List<HomeEventDto>> getNearbyEvents({
    required double latitude,
    required double longitude,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<HomeClassificationDto>> getClassifications() async {
    final response = await _dio.get<String>('classifications.json');
    return IsolateParser.run(_parseHomeClassifications, response.data ?? '{}');
  }

  @override
  Future<List<HomeEventDto>> getUpcomingEvents({
    required String city,
    required DateTime startDateTime,
  }) {
    return _getEvents({
      'city': city,
      'startDateTime': TicketmasterDateTime.format(startDateTime),
      'sort': 'date,asc',
      'size': 10,
    });
  }

  @override
  Future<List<HomeEventDto>> getNearbyEvents({
    required double latitude,
    required double longitude,
  }) {
    return _getEvents({
      'latlong': '$latitude,$longitude',
      'radius': 20,
      'unit': 'km',
      'sort': 'distance,asc',
      'size': 10,
    });
  }

  Future<List<HomeEventDto>> _getEvents(
    Map<String, dynamic> queryParameters,
  ) async {
    final response = await _dio.get<String>(
      'events.json',
      queryParameters: queryParameters,
    );
    return IsolateParser.run(_parseHomeEvents, response.data ?? '{}');
  }
}

List<HomeClassificationDto> _parseHomeClassifications(String responseBody) {
  final data = _decodeMap(responseBody);
  final embedded = _asMap(data['_embedded']);
  final items = _asList(embedded?['classifications']);
  return items
      .whereType<Map<String, dynamic>>()
      .map(HomeClassificationDto.fromJson)
      .toList();
}

List<HomeEventDto> _parseHomeEvents(String responseBody) {
  final data = _decodeMap(responseBody);
  final embedded = _asMap(data['_embedded']);
  final items = _asList(embedded?['events']);
  return items
      .whereType<Map<String, dynamic>>()
      .map(HomeEventDto.fromJson)
      .toList();
}

Map<String, dynamic> _decodeMap(String responseBody) {
  final decoded = jsonDecode(responseBody);
  return decoded is Map<String, dynamic> ? decoded : const {};
}

Map<String, dynamic>? _asMap(Object? value) {
  return value is Map<String, dynamic> ? value : null;
}

List<dynamic> _asList(Object? value) {
  return value is List<dynamic> ? value : const [];
}

import 'package:dio/dio.dart';

import '../../../../core/networking/ticketmaster_date_time.dart';
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
    final response = await _dio.get<Map<String, dynamic>>(
      'classifications.json',
    );
    final embedded = _asMap(response.data?['_embedded']);
    final items = _asList(embedded?['classifications']);
    return items
        .whereType<Map<String, dynamic>>()
        .map(HomeClassificationDto.fromJson)
        .toList();
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
    final response = await _dio.get<Map<String, dynamic>>(
      'events.json',
      queryParameters: queryParameters,
    );
    final embedded = _asMap(response.data?['_embedded']);
    final items = _asList(embedded?['events']);
    return items
        .whereType<Map<String, dynamic>>()
        .map(HomeEventDto.fromJson)
        .toList();
  }

  Map<String, dynamic>? _asMap(Object? value) {
    return value is Map<String, dynamic> ? value : null;
  }

  List<dynamic> _asList(Object? value) {
    return value is List<dynamic> ? value : const [];
  }
}

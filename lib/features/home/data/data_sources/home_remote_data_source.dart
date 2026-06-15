import 'package:dio/dio.dart';

import '../../../../core/helpers/json_extensions.dart';
import '../../../../core/utils/isolate_parser.dart';
import '../models/home_classification_dto.dart';
import '../models/home_event_dto.dart';
import '../models/home_events_query_params.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeClassificationDto>> getClassifications();

  Future<List<HomeEventDto>> getEvents(HomeEventsQueryParams query);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<HomeClassificationDto>> getClassifications() async {
    final response = await _dio.get<Map<String, dynamic>>(
      'classifications.json',
    );
    return IsolateParser.run(
      _parseHomeClassifications,
      response.data ?? const <String, dynamic>{},
    );
  }

  @override
  Future<List<HomeEventDto>> getEvents(HomeEventsQueryParams query) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'events.json',
      queryParameters: query.toJson(),
    );
    return IsolateParser.run(
      _parseHomeEvents,
      response.data ?? const <String, dynamic>{},
    );
  }
}

List<HomeClassificationDto> _parseHomeClassifications(
  Map<String, dynamic> data,
) {
  final embedded = (data['_embedded'] as Object?).asJsonMap();
  final items = (embedded?['classifications'] as Object?).asJsonList();
  return items
      .whereType<Map<String, dynamic>>()
      .map(HomeClassificationDto.fromJson)
      .toList();
}

List<HomeEventDto> _parseHomeEvents(Map<String, dynamic> data) {
  final embedded = (data['_embedded'] as Object?).asJsonMap();
  final items = (embedded?['events'] as Object?).asJsonList();
  return items
      .whereType<Map<String, dynamic>>()
      .map(HomeEventDto.fromJson)
      .toList();
}

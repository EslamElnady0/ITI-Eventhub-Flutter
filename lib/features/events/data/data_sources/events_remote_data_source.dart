import 'package:dio/dio.dart';

import '../../../../core/helpers/json_extensions.dart';
import '../../../../core/utils/isolate_parser.dart';
import '../models/event_dto.dart';
import '../models/events_query_params.dart';

class EventDtoPage {
  const EventDtoPage({
    required this.events,
    required this.page,
    required this.totalPages,
  });

  final List<EventDto> events;
  final int page;
  final int totalPages;
}

abstract class EventsRemoteDataSource {
  Future<EventDtoPage> getEvents(EventsQueryParams query);

  Future<EventDto> getEventDetails(String eventId);
}

class EventsRemoteDataSourceImpl implements EventsRemoteDataSource {
  const EventsRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<EventDtoPage> getEvents(EventsQueryParams query) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'events.json',
      queryParameters: query.toJson(),
    );
    return IsolateParser.run(
      _parseEventPage,
      _EventPageParserMessage(
        responseData: response.data ?? const <String, dynamic>{},
        fallbackPage: query.page,
      ),
    );
  }

  @override
  Future<EventDto> getEventDetails(String eventId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'events/$eventId.json',
    );
    return IsolateParser.run(
      _parseEventDetails,
      response.data ?? const <String, dynamic>{},
    );
  }
}

class _EventPageParserMessage {
  const _EventPageParserMessage({
    required this.responseData,
    required this.fallbackPage,
  });

  final Map<String, dynamic> responseData;
  final int fallbackPage;
}

EventDtoPage _parseEventPage(_EventPageParserMessage message) {
  final data = message.responseData;
  final embedded = (data['_embedded'] as Object?).asJsonMap();
  final items = (embedded?['events'] as Object?).asJsonList();
  final page = (data['page'] as Object?).asJsonMap();

  return EventDtoPage(
    events: items
        .whereType<Map<String, dynamic>>()
        .map(EventDto.fromJson)
        .toList(),
    page: (page?['number'] as num?)?.toInt() ?? message.fallbackPage,
    totalPages: (page?['totalPages'] as num?)?.toInt() ?? 0,
  );
}

EventDto _parseEventDetails(Map<String, dynamic> responseData) {
  return EventDto.fromJson(responseData);
}

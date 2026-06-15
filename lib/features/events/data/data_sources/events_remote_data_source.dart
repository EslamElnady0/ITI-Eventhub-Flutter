import 'package:dio/dio.dart';

import '../../../../core/helpers/json_extensions.dart';
import '../../../../core/networking/ticketmaster_date_time.dart';
import '../../../../core/utils/isolate_parser.dart';
import '../entities/event_query.dart';
import '../models/event_dto.dart';

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
  Future<EventDtoPage> getEvents(EventQuery query);

  Future<EventDto> getEventDetails(String eventId);
}

class EventsRemoteDataSourceImpl implements EventsRemoteDataSource {
  const EventsRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<EventDtoPage> getEvents(EventQuery query) async {
    final queryParameters = <String, dynamic>{
      'size': query.size,
      'page': query.page,
    };

    if (query.keyword.trim().isNotEmpty) {
      queryParameters['keyword'] = query.keyword.trim();
    }
    if (query.city.trim().isNotEmpty && query.mode != EventListMode.nearby) {
      queryParameters['city'] = query.city.trim();
    }
    if (query.classificationName.trim().isNotEmpty) {
      queryParameters['classificationName'] = query.classificationName.trim();
    }

    if (query.mode == EventListMode.nearby) {
      queryParameters.addAll({
        'latlong': '40.7484,-73.9857',
        'radius': 20,
        'unit': 'km',
        'sort': 'distance,asc',
      });
    } else if (query.mode == EventListMode.past) {
      queryParameters.addAll({
        'endDateTime': TicketmasterDateTime.format(DateTime.now()),
        'sort': 'date,desc',
      });
    } else {
      queryParameters['sort'] = 'date,asc';
      final range = _dateRange(query);
      queryParameters['startDateTime'] = TicketmasterDateTime.format(range.$1);
      if (range.$2 != null) {
        queryParameters['endDateTime'] = TicketmasterDateTime.format(range.$2!);
      }
    }

    final response = await _dio.get<Map<String, dynamic>>(
      'events.json',
      queryParameters: queryParameters,
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

  (DateTime, DateTime?) _dateRange(EventQuery query) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    switch (query.datePreset) {
      case EventDatePreset.today:
        return (today, today.add(const Duration(days: 1)));
      case EventDatePreset.tomorrow:
        final tomorrow = today.add(const Duration(days: 1));
        return (tomorrow, tomorrow.add(const Duration(days: 1)));
      case EventDatePreset.thisWeek:
        final daysUntilSunday = DateTime.sunday - today.weekday;
        return (today, today.add(Duration(days: daysUntilSunday + 1)));
      case EventDatePreset.custom:
        final custom = query.customDate ?? today;
        final start = DateTime(custom.year, custom.month, custom.day);
        return (start, start.add(const Duration(days: 1)));
      case EventDatePreset.any:
        return (now, null);
    }
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

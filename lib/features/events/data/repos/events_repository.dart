import '../../../../core/errors/app_failure.dart';
import '../data_sources/events_remote_data_source.dart';
import '../entities/event_entity.dart';
import '../entities/event_query.dart';
import '../models/events_query_params.dart';

abstract class EventsRepository {
  Future<EventPage> getEvents(EventQuery query);

  Future<EventEntity> getEventDetails(String eventId);
}

class EventsRepositoryImpl implements EventsRepository {
  const EventsRepositoryImpl(this._remoteDataSource);

  final EventsRemoteDataSource _remoteDataSource;

  @override
  Future<EventPage> getEvents(EventQuery query) async {
    try {
      final result = await _remoteDataSource.getEvents(_toQueryParams(query));
      var events = result.events.map((event) => event.toEntity()).toList();

      if (query.hasPriceFilter) {
        events = events.where((event) {
          if (!event.hasPrice) return false;
          return event.maxPrice >= query.minPrice! &&
              event.minPrice <= query.maxPrice!;
        }).toList();
      }

      return EventPage(
        events: events,
        page: result.page,
        totalPages: result.totalPages,
      );
    } catch (error) {
      throw AppFailure.fromException(error);
    }
  }

  @override
  Future<EventEntity> getEventDetails(String eventId) async {
    try {
      return (await _remoteDataSource.getEventDetails(eventId)).toEntity();
    } catch (error) {
      throw AppFailure.fromException(error);
    }
  }

  EventsQueryParams _toQueryParams(EventQuery query) {
    final commonParams = (
      keyword: query.keyword,
      classificationName: query.classificationName,
      page: query.page,
      size: query.size,
    );

    switch (query.mode) {
      case EventListMode.nearby:
        return EventsQueryParams(
          keyword: commonParams.keyword,
          classificationName: commonParams.classificationName,
          latitude: 40.7484,
          longitude: -73.9857,
          radius: 20,
          unit: 'km',
          sort: 'distance,asc',
          page: commonParams.page,
          size: commonParams.size,
        );
      case EventListMode.past:
        return EventsQueryParams(
          keyword: commonParams.keyword,
          city: query.city,
          classificationName: commonParams.classificationName,
          endDateTime: DateTime.now(),
          sort: 'date,desc',
          page: commonParams.page,
          size: commonParams.size,
        );
      case EventListMode.upcoming:
        final range = _dateRange(query);
        return EventsQueryParams(
          keyword: commonParams.keyword,
          city: query.city,
          classificationName: commonParams.classificationName,
          startDateTime: range.$1,
          endDateTime: range.$2,
          sort: 'date,asc',
          page: commonParams.page,
          size: commonParams.size,
        );
    }
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

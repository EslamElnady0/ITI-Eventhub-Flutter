import '../../../../core/errors/app_failure.dart';
import '../data_sources/events_remote_data_source.dart';
import '../entities/event_entity.dart';
import '../entities/event_query.dart';

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
      final result = await _remoteDataSource.getEvents(query);
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
}

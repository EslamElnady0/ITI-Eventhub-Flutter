import 'event_entity.dart';

enum EventListMode { upcoming, past, nearby }

enum EventDatePreset { any, today, tomorrow, thisWeek, custom }

class EventQuery {
  const EventQuery({
    this.keyword = '',
    this.city = 'New York',
    this.classificationName = '',
    this.datePreset = EventDatePreset.any,
    this.customDate,
    this.minPrice,
    this.maxPrice,
    this.page = 0,
    this.size = 20,
    this.mode = EventListMode.upcoming,
  });

  final String keyword;
  final String city;
  final String classificationName;
  final EventDatePreset datePreset;
  final DateTime? customDate;
  final double? minPrice;
  final double? maxPrice;
  final int page;
  final int size;
  final EventListMode mode;

  bool get hasPriceFilter => minPrice != null && maxPrice != null;

  EventQuery copyWith({
    String? keyword,
    String? city,
    String? classificationName,
    EventDatePreset? datePreset,
    DateTime? customDate,
    bool clearCustomDate = false,
    double? minPrice,
    double? maxPrice,
    bool clearPrice = false,
    int? page,
    int? size,
    EventListMode? mode,
  }) {
    return EventQuery(
      keyword: keyword ?? this.keyword,
      city: city ?? this.city,
      classificationName: classificationName ?? this.classificationName,
      datePreset: datePreset ?? this.datePreset,
      customDate: clearCustomDate ? null : customDate ?? this.customDate,
      minPrice: clearPrice ? null : minPrice ?? this.minPrice,
      maxPrice: clearPrice ? null : maxPrice ?? this.maxPrice,
      page: page ?? this.page,
      size: size ?? this.size,
      mode: mode ?? this.mode,
    );
  }
}

class EventPage {
  const EventPage({
    required this.events,
    required this.page,
    required this.totalPages,
  });

  final List<EventEntity> events;
  final int page;
  final int totalPages;

  bool get hasMore => page + 1 < totalPages;
}

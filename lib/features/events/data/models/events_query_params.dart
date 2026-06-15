import '../../../../core/networking/ticketmaster_date_time.dart';

class EventsQueryParams {
  const EventsQueryParams({
    this.keyword = '',
    this.city = '',
    this.classificationName = '',
    this.startDateTime,
    this.endDateTime,
    this.latitude,
    this.longitude,
    this.radius,
    this.unit,
    required this.sort,
    required this.page,
    required this.size,
  });

  final String keyword;
  final String city;
  final String classificationName;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final double? latitude;
  final double? longitude;
  final int? radius;
  final String? unit;
  final String sort;
  final int page;
  final int size;

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'page': page,
      'sort': sort,
      if (keyword.trim().isNotEmpty) 'keyword': keyword.trim(),
      if (city.trim().isNotEmpty) 'city': city.trim(),
      if (classificationName.trim().isNotEmpty)
        'classificationName': classificationName.trim(),
      if (startDateTime != null)
        'startDateTime': TicketmasterDateTime.format(startDateTime!),
      if (endDateTime != null)
        'endDateTime': TicketmasterDateTime.format(endDateTime!),
      if (latitude != null && longitude != null)
        'latlong': '$latitude,$longitude',
      if (radius != null) 'radius': radius,
      if (unit != null && unit!.trim().isNotEmpty) 'unit': unit,
    };
  }
}

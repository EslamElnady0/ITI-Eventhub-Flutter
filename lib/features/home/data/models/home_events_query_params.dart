import '../../../../core/networking/ticketmaster_date_time.dart';

abstract class HomeEventsQueryParams {
  const HomeEventsQueryParams();

  Map<String, dynamic> toJson();
}

class UpcomingEventsQueryParams extends HomeEventsQueryParams {
  const UpcomingEventsQueryParams({
    required this.city,
    required this.startDateTime,
    this.size = 10,
  });

  final String city;
  final DateTime startDateTime;
  final int size;

  @override
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'startDateTime': TicketmasterDateTime.format(startDateTime),
      'sort': 'date,asc',
      'size': size,
    };
  }
}

class NearbyEventsQueryParams extends HomeEventsQueryParams {
  const NearbyEventsQueryParams({
    required this.latitude,
    required this.longitude,
    this.radius = 20,
    this.unit = 'km',
    this.size = 10,
  });

  final double latitude;
  final double longitude;
  final int radius;
  final String unit;
  final int size;

  @override
  Map<String, dynamic> toJson() {
    return {
      'latlong': '$latitude,$longitude',
      'radius': radius,
      'unit': unit,
      'sort': 'distance,asc',
      'size': size,
    };
  }
}

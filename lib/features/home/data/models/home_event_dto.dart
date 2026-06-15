import 'package:intl/intl.dart';

import '../../../../core/helpers/json_extensions.dart';
import '../entities/home_event_entity.dart';

class HomeEventDto {
  const HomeEventDto({
    this.id = '',
    this.name = '',
    this.imageUrl = '',
    this.localDate = '',
    this.localTime = '',
    this.venueName = '',
    this.city = '',
    this.address = '',
    this.distance = 0,
  });

  final String? id;
  final String? name;
  final String? imageUrl;
  final String? localDate;
  final String? localTime;
  final String? venueName;
  final String? city;
  final String? address;
  final double? distance;

  factory HomeEventDto.fromJson(Map<String, dynamic> json) {
    final dates = (json['dates'] as Object?).asJsonMap();
    final start = (dates?['start'] as Object?).asJsonMap();
    final embedded = (json['_embedded'] as Object?).asJsonMap();
    final venues = (embedded?['venues'] as Object?).asJsonList();
    final venue = venues.whereType<Map<String, dynamic>>().firstOrNull;
    final city = (venue?['city'] as Object?).asJsonMap();
    final address = (venue?['address'] as Object?).asJsonMap();
    final images = (json['images'] as Object?)
        .asJsonList()
        .whereType<Map<String, dynamic>>()
        .toList();
    images.sort(
      (a, b) =>
          ((b['width'] as num?) ?? 0).compareTo((a['width'] as num?) ?? 0),
    );

    return HomeEventDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      imageUrl: images.firstOrNull?['url'] as String?,
      localDate: start?['localDate'] as String?,
      localTime: start?['localTime'] as String?,
      venueName: venue?['name'] as String?,
      city: city?['name'] as String?,
      address: address?['line1'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
    );
  }

  HomeEventEntity toEntity() {
    final parsedDate = DateTime.tryParse(localDate ?? '');
    final dateLabel = parsedDate == null
        ? 'Date to be announced'
        : DateFormat('EEE, MMM d').format(parsedDate).toUpperCase();
    final time = _formatTime(localTime);
    final locationParts = [
      venueName,
      address,
      city,
    ].where((value) => value != null && value.trim().isNotEmpty);

    return HomeEventEntity(
      id: id?.trim().isNotEmpty == true ? id!.trim() : 'unknown-event',
      title: name?.trim().isNotEmpty == true ? name!.trim() : 'Untitled event',
      imageUrl: imageUrl ?? '',
      day: parsedDate == null ? '--' : DateFormat('dd').format(parsedDate),
      month: parsedDate == null
          ? 'TBA'
          : DateFormat('MMM').format(parsedDate).toUpperCase(),
      dateLabel: time.isEmpty ? dateLabel : '$dateLabel - $time',
      location: locationParts.isEmpty
          ? 'Location to be announced'
          : locationParts.join(', '),
      distanceLabel: (distance ?? 0) > 0
          ? '${distance!.toStringAsFixed(1)} km away'
          : '',
    );
  }

  static String _formatTime(String? value) {
    if (value == null || value.isEmpty) return '';
    final date = DateTime.tryParse('2000-01-01T$value');
    return date == null ? '' : DateFormat('h:mm a').format(date);
  }
}

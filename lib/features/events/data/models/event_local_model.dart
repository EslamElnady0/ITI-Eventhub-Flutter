import '../entities/event_entity.dart';

class EventLocalModel {
  const EventLocalModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.dateTime,
    required this.dateLabel,
    required this.timeLabel,
    required this.venue,
    required this.address,
    required this.locationLabel,
    required this.organizer,
    required this.organizerImageUrl,
    required this.description,
    required this.category,
    required this.minPrice,
    required this.maxPrice,
    required this.currency,
    required this.priceLabel,
    required this.hasPrice,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.distanceLabel,
    required this.ticketUrl,
  });

  final String id;
  final String title;
  final String imageUrl;
  final DateTime dateTime;
  final String dateLabel;
  final String timeLabel;
  final String venue;
  final String address;
  final String locationLabel;
  final String organizer;
  final String organizerImageUrl;
  final String description;
  final String category;
  final double minPrice;
  final double maxPrice;
  final String currency;
  final String priceLabel;
  final bool hasPrice;
  final double latitude;
  final double longitude;
  final double distance;
  final String distanceLabel;
  final String ticketUrl;

  factory EventLocalModel.fromEntity(EventEntity entity) {
    return EventLocalModel(
      id: entity.id,
      title: entity.title,
      imageUrl: entity.imageUrl,
      dateTime: entity.dateTime,
      dateLabel: entity.dateLabel,
      timeLabel: entity.timeLabel,
      venue: entity.venue,
      address: entity.address,
      locationLabel: entity.locationLabel,
      organizer: entity.organizer,
      organizerImageUrl: entity.organizerImageUrl,
      description: entity.description,
      category: entity.category,
      minPrice: entity.minPrice,
      maxPrice: entity.maxPrice,
      currency: entity.currency,
      priceLabel: entity.priceLabel,
      hasPrice: entity.hasPrice,
      latitude: entity.latitude,
      longitude: entity.longitude,
      distance: entity.distance,
      distanceLabel: entity.distanceLabel,
      ticketUrl: entity.ticketUrl,
    );
  }

  factory EventLocalModel.fromMap(Map<String, Object?> map) {
    return EventLocalModel(
      id: map['event_id'] as String? ?? '',
      title: map['title'] as String? ?? 'Untitled event',
      imageUrl: map['image_url'] as String? ?? '',
      dateTime:
          DateTime.tryParse(map['date_time'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      dateLabel: map['date_label'] as String? ?? 'Date to be announced',
      timeLabel: map['time_label'] as String? ?? 'Time to be announced',
      venue: map['venue'] as String? ?? 'Venue to be announced',
      address: map['address'] as String? ?? 'Address to be announced',
      locationLabel:
          map['location_label'] as String? ?? 'Location to be announced',
      organizer: map['organizer'] as String? ?? 'Ticketmaster Event',
      organizerImageUrl: map['organizer_image_url'] as String? ?? '',
      description:
          map['description'] as String? ??
          'No additional event information is available.',
      category: map['category'] as String? ?? 'Event',
      minPrice: (map['min_price'] as num?)?.toDouble() ?? 0,
      maxPrice: (map['max_price'] as num?)?.toDouble() ?? 0,
      currency: map['currency'] as String? ?? 'USD',
      priceLabel: map['price_label'] as String? ?? 'See ticket options',
      hasPrice: ((map['has_price'] as num?)?.toInt() ?? 0) == 1,
      latitude: (map['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 0,
      distance: (map['distance'] as num?)?.toDouble() ?? 0,
      distanceLabel: map['distance_label'] as String? ?? '',
      ticketUrl: map['ticket_url'] as String? ?? '',
    );
  }

  Map<String, Object?> toMap({required String userId}) {
    return {
      'user_id': userId,
      'event_id': id,
      'title': title,
      'image_url': imageUrl,
      'date_time': dateTime.toIso8601String(),
      'date_label': dateLabel,
      'time_label': timeLabel,
      'venue': venue,
      'address': address,
      'location_label': locationLabel,
      'organizer': organizer,
      'organizer_image_url': organizerImageUrl,
      'description': description,
      'category': category,
      'min_price': minPrice,
      'max_price': maxPrice,
      'currency': currency,
      'price_label': priceLabel,
      'has_price': hasPrice ? 1 : 0,
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
      'distance_label': distanceLabel,
      'ticket_url': ticketUrl,
    };
  }

  EventEntity toEntity() {
    return EventEntity(
      id: id,
      title: title,
      imageUrl: imageUrl,
      dateTime: dateTime,
      dateLabel: dateLabel,
      timeLabel: timeLabel,
      venue: venue,
      address: address,
      locationLabel: locationLabel,
      organizer: organizer,
      organizerImageUrl: organizerImageUrl,
      description: description,
      category: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
      currency: currency,
      priceLabel: priceLabel,
      hasPrice: hasPrice,
      latitude: latitude,
      longitude: longitude,
      distance: distance,
      distanceLabel: distanceLabel,
      ticketUrl: ticketUrl,
    );
  }
}

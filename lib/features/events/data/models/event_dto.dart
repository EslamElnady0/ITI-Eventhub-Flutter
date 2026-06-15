import 'package:intl/intl.dart';

import '../entities/event_entity.dart';

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

class EventDto {
  const EventDto({
    this.id = '',
    this.name = '',
    this.ticketUrl = '',
    this.imageUrl = '',
    this.localDate = '',
    this.localTime = '',
    this.venue = '',
    this.city = '',
    this.address = '',
    this.organizer = '',
    this.organizerImageUrl = '',
    this.info = '',
    this.pleaseNote = '',
    this.category = '',
    this.minPrice = 0,
    this.maxPrice = 0,
    this.currency = '',
    this.latitude = 0,
    this.longitude = 0,
    this.distance = 0,
  });

  final String? id;
  final String? name;
  final String? ticketUrl;
  final String? imageUrl;
  final String? localDate;
  final String? localTime;
  final String? venue;
  final String? city;
  final String? address;
  final String? organizer;
  final String? organizerImageUrl;
  final String? info;
  final String? pleaseNote;
  final String? category;
  final double? minPrice;
  final double? maxPrice;
  final String? currency;
  final double? latitude;
  final double? longitude;
  final double? distance;

  factory EventDto.fromJson(Map<String, dynamic> json) {
    final dates = json['dates'] as Map<String, dynamic>?;
    final start = dates?['start'] as Map<String, dynamic>?;
    final embedded = json['_embedded'] as Map<String, dynamic>?;
    final venues = embedded?['venues'] as List<dynamic>?;
    final venueJson = venues?.whereType<Map<String, dynamic>>().firstOrNull;
    final cityJson = venueJson?['city'] as Map<String, dynamic>?;
    final addressJson = venueJson?['address'] as Map<String, dynamic>?;
    final location = venueJson?['location'] as Map<String, dynamic>?;
    final attractions = embedded?['attractions'] as List<dynamic>?;
    final attraction = attractions
        ?.whereType<Map<String, dynamic>>()
        .firstOrNull;
    final classifications = json['classifications'] as List<dynamic>?;
    final classification = classifications
        ?.whereType<Map<String, dynamic>>()
        .firstOrNull;
    final segment = classification?['segment'] as Map<String, dynamic>?;
    final images = _sortedImages(json['images']);
    final attractionImages = _sortedImages(attraction?['images']);
    final priceRanges = json['priceRanges'] as List<dynamic>?;
    final price = priceRanges?.whereType<Map<String, dynamic>>().firstOrNull;

    return EventDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      ticketUrl: json['url'] as String?,
      imageUrl: images.firstOrNull?['url'] as String?,
      localDate: start?['localDate'] as String?,
      localTime: start?['localTime'] as String?,
      venue: venueJson?['name'] as String?,
      city: cityJson?['name'] as String?,
      address: addressJson?['line1'] as String?,
      organizer: attraction?['name'] as String?,
      organizerImageUrl: attractionImages.firstOrNull?['url'] as String?,
      info: json['info'] as String?,
      pleaseNote: json['pleaseNote'] as String?,
      category: segment?['name'] as String?,
      minPrice: (price?['min'] as num?)?.toDouble(),
      maxPrice: (price?['max'] as num?)?.toDouble(),
      currency: price?['currency'] as String?,
      latitude: double.tryParse(location?['latitude'] as String? ?? ''),
      longitude: double.tryParse(location?['longitude'] as String? ?? ''),
      distance: (json['distance'] as num?)?.toDouble(),
    );
  }

  EventEntity toEntity() {
    final parsedDate =
        DateTime.tryParse(localDate ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0);
    final parsedTime = _parseTime(localTime);
    final eventDateTime = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
      parsedTime?.hour ?? 0,
      parsedTime?.minute ?? 0,
    );
    final hasKnownDate = (localDate ?? '').isNotEmpty;
    final hasKnownPrice = minPrice != null || maxPrice != null;
    final safeMinPrice = minPrice ?? maxPrice ?? 0;
    final safeMaxPrice = maxPrice ?? minPrice ?? 0;
    final safeCurrency = currency?.trim().isNotEmpty == true
        ? currency!.trim()
        : 'USD';
    final locationParts = [
      venue,
      address,
      city,
    ].where((value) => value != null && value.trim().isNotEmpty);
    final descriptionParts = [
      info,
      pleaseNote,
    ].where((value) => value != null && value.trim().isNotEmpty);

    return EventEntity(
      id: id?.trim().isNotEmpty == true ? id!.trim() : 'unknown-event',
      title: name?.trim().isNotEmpty == true ? name!.trim() : 'Untitled event',
      imageUrl: imageUrl ?? '',
      dateTime: eventDateTime,
      dateLabel: hasKnownDate
          ? DateFormat('d MMMM, y').format(eventDateTime)
          : 'Date to be announced',
      timeLabel: parsedTime == null
          ? 'Time to be announced'
          : DateFormat('EEEE, h:mm a').format(eventDateTime),
      venue: venue?.trim().isNotEmpty == true
          ? venue!.trim()
          : 'Venue to be announced',
      address: address?.trim().isNotEmpty == true
          ? address!.trim()
          : 'Address to be announced',
      locationLabel: locationParts.isEmpty
          ? 'Location to be announced'
          : locationParts.join(', '),
      organizer: organizer?.trim().isNotEmpty == true
          ? organizer!.trim()
          : 'Ticketmaster Event',
      organizerImageUrl: organizerImageUrl ?? '',
      description: descriptionParts.isEmpty
          ? 'No additional event information is available.'
          : descriptionParts.join('\n\n'),
      category: category?.trim().isNotEmpty == true
          ? category!.trim()
          : 'Event',
      minPrice: safeMinPrice,
      maxPrice: safeMaxPrice,
      currency: safeCurrency,
      priceLabel: hasKnownPrice
          ? _priceLabel(safeMinPrice, safeMaxPrice, safeCurrency)
          : 'See ticket options',
      hasPrice: hasKnownPrice,
      latitude: latitude ?? 0,
      longitude: longitude ?? 0,
      distance: distance ?? 0,
      distanceLabel: (distance ?? 0) > 0
          ? '${distance!.toStringAsFixed(1)} km away'
          : '',
      ticketUrl: ticketUrl ?? '',
    );
  }

  static List<Map<String, dynamic>> _sortedImages(Object? value) {
    final images =
        (value as List<dynamic>?)?.whereType<Map<String, dynamic>>().toList() ??
        [];
    images.sort(
      (a, b) =>
          ((b['width'] as num?) ?? 0).compareTo((a['width'] as num?) ?? 0),
    );
    return images;
  }

  static DateTime? _parseTime(String? value) {
    if (value == null || value.isEmpty) return null;
    return DateTime.tryParse('2000-01-01T$value');
  }

  static String _priceLabel(double min, double max, String currency) {
    final format = NumberFormat.currency(
      name: currency,
      symbol: currency == 'USD' ? '\$' : '$currency ',
      decimalDigits: 0,
    );
    if (min == max) return format.format(min);
    return '${format.format(min)} - ${format.format(max)}';
  }
}

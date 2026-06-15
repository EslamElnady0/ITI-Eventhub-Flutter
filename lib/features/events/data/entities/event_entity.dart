class EventEntity {
  const EventEntity({
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
}

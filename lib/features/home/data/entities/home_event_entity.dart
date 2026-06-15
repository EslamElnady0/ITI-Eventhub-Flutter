class HomeEventEntity {
  const HomeEventEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.day,
    required this.month,
    required this.dateLabel,
    required this.location,
    required this.distanceLabel,
  });

  final String id;
  final String title;
  final String imageUrl;
  final String day;
  final String month;
  final String dateLabel;
  final String location;
  final String distanceLabel;
}

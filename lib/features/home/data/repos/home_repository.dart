import '../../../../core/errors/app_failure.dart';
import '../data_sources/home_remote_data_source.dart';
import '../entities/home_category_entity.dart';
import '../entities/home_event_entity.dart';
import '../models/home_events_query_params.dart';

class HomeData {
  const HomeData({
    required this.categories,
    required this.upcomingEvents,
    required this.nearbyEvents,
  });

  final List<HomeCategoryEntity> categories;
  final List<HomeEventEntity> upcomingEvents;
  final List<HomeEventEntity> nearbyEvents;
}

abstract class HomeRepository {
  Future<HomeData> getHomeData();
}

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._remoteDataSource);

  final HomeRemoteDataSource _remoteDataSource;

  @override
  Future<HomeData> getHomeData() async {
    try {
      final classifications = await _remoteDataSource.getClassifications();
      final upcomingEventDtos = await _remoteDataSource.getEvents(
        UpcomingEventsQueryParams(
          city: 'New York',
          startDateTime: DateTime.now(),
        ),
      );
      final nearbyEventDtos = await _remoteDataSource.getEvents(
        const NearbyEventsQueryParams(latitude: 40.7484, longitude: -73.9857),
      );

      final categories = classifications
          .map((dto) => dto.toEntity())
          .whereType<HomeCategoryEntity>()
          .fold<List<HomeCategoryEntity>>([], (uniqueCategories, category) {
            final alreadyAdded = uniqueCategories.any(
              (item) => item.name == category.name,
            );
            if (!alreadyAdded) uniqueCategories.add(category);
            return uniqueCategories;
          })
          .take(10)
          .toList();

      return HomeData(
        categories: categories,
        upcomingEvents: upcomingEventDtos.map((dto) => dto.toEntity()).toList(),
        nearbyEvents: nearbyEventDtos.map((dto) => dto.toEntity()).toList(),
      );
    } catch (error) {
      throw AppFailure.fromException(error);
    }
  }
}

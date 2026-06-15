part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.categories = const [],
    this.upcomingEvents = const [],
    this.nearbyEvents = const [],
    this.errorMessage = '',
  });

  final HomeStatus status;
  final List<HomeCategoryEntity> categories;
  final List<HomeEventEntity> upcomingEvents;
  final List<HomeEventEntity> nearbyEvents;
  final String errorMessage;

  HomeState copyWith({
    HomeStatus? status,
    List<HomeCategoryEntity>? categories,
    List<HomeEventEntity>? upcomingEvents,
    List<HomeEventEntity>? nearbyEvents,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      upcomingEvents: upcomingEvents ?? this.upcomingEvents,
      nearbyEvents: nearbyEvents ?? this.nearbyEvents,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    categories,
    upcomingEvents,
    nearbyEvents,
    errorMessage,
  ];
}

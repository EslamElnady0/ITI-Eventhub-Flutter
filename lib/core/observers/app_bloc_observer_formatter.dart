part of 'app_bloc_observer.dart';

extension AppBlocObserverFormatter on AppBlocObserver {
  String formatState(Object? state) {
    return switch (state) {
      HomeState() =>
        'HomeState(status: ${state.status}, '
            'categories: ${state.categories.length}, '
            'upcomingEvents: ${state.upcomingEvents.length}, '
            'nearbyEvents: ${state.nearbyEvents.length}, '
            'errorMessage: ${state.errorMessage})',
      EventsListState() =>
        'EventsListState(mode: ${state.mode}, '
            'status: ${state.status}, '
            'events: ${state.events.length}, '
            'page: ${state.page}, '
            'hasMore: ${state.hasMore}, '
            'isLoadingMore: ${state.isLoadingMore}, '
            'errorMessage: ${state.errorMessage})',
      SearchState() =>
        'SearchState(status: ${state.status}, '
            'events: ${state.events.length}, '
            'page: ${state.page}, '
            'hasMore: ${state.hasMore}, '
            'isLoadingMore: ${state.isLoadingMore}, '
            'errorMessage: ${state.errorMessage})',
      EventDetailsState() =>
        'EventDetailsState(status: ${state.status}, '
            'eventId: ${state.event?.id}, '
            'eventTitle: ${state.event?.title}, '
            'errorMessage: ${state.errorMessage})',
      FavoritesState() =>
        'FavoritesState(status: ${state.status}, '
            'favoriteIds: ${state.favoriteIds}, '
            'eventsCount: ${state.events.length}, '
            'errorMessage: ${state.errorMessage})',
      AuthState() => state.toString(),
      ProfileState() => state.toString(),
      _ => state.toString(),
    };
  }
}

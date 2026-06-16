part of 'favorites_cubit.dart';

enum FavoritesStatus { initial, loading, success, failure }

class FavoritesState extends Equatable {
  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.favoriteIds = const {},
    this.events = const [],
    this.errorMessage = '',
  });

  final FavoritesStatus status;
  final Set<String> favoriteIds;
  final List<EventEntity> events;
  final String errorMessage;

  FavoritesState copyWith({
    FavoritesStatus? status,
    Set<String>? favoriteIds,
    List<EventEntity>? events,
    String? errorMessage,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      events: events ?? this.events,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, favoriteIds, events, errorMessage];
}

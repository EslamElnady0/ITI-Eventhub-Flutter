part of 'events_list_cubit.dart';

enum ListStatus { initial, loading, success, failure }

class EventsListState extends Equatable {
  const EventsListState({
    required this.mode,
    this.status = ListStatus.initial,
    this.events = const [],
    this.page = 0,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.errorMessage = '',
  });

  final EventListMode mode;
  final ListStatus status;
  final List<EventEntity> events;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final String errorMessage;

  EventsListState copyWith({
    EventListMode? mode,
    ListStatus? status,
    List<EventEntity>? events,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    String? errorMessage,
  }) {
    return EventsListState(
      mode: mode ?? this.mode,
      status: status ?? this.status,
      events: events ?? this.events,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    mode,
    status,
    events,
    page,
    hasMore,
    isLoadingMore,
    errorMessage,
  ];
}

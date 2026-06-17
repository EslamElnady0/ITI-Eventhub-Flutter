part of 'search_cubit.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.query = const EventQuery(),
    this.events = const [],
    this.page = 0,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.errorMessage = '',
  });

  final SearchStatus status;
  final EventQuery query;
  final List<EventEntity> events;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final String errorMessage;

  SearchState copyWith({
    SearchStatus? status,
    EventQuery? query,
    List<EventEntity>? events,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    String? errorMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      events: events ?? this.events,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    query,
    events,
    page,
    hasMore,
    isLoadingMore,
    errorMessage,
  ];
}

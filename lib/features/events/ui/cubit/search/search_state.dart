part of 'search_cubit.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.events = const [],
    this.page = 0,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.errorMessage = '',
  });

  final SearchStatus status;
  final List<EventEntity> events;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final String errorMessage;

  SearchState copyWith({
    SearchStatus? status,
    List<EventEntity>? events,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    String? errorMessage,
  }) {
    return SearchState(
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
    status,
    events,
    page,
    hasMore,
    isLoadingMore,
    errorMessage,
  ];
}

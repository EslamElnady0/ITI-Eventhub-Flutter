import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/app_failure.dart';
import '../../data/entities/event_entity.dart';
import '../../data/entities/event_query.dart';
import '../../data/repos/events_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._repository) : super(const SearchState());

  final EventsRepository _repository;
  Timer? _debounce;
  EventQuery _query = const EventQuery();
  int _requestId = 0;

  Future<void> loadInitial() => _search(refresh: true);

  void keywordChanged(String keyword) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 450), () {
      _query = _query.copyWith(keyword: keyword, page: 0);
      _search(refresh: true);
    });
  }

  Future<void> applyFilters({
    required String classificationName,
    required EventDatePreset datePreset,
    required DateTime? customDate,
    required double? minPrice,
    required double? maxPrice,
  }) async {
    _query = _query.copyWith(
      classificationName: classificationName,
      datePreset: datePreset,
      customDate: customDate,
      clearCustomDate: customDate == null,
      minPrice: minPrice,
      maxPrice: maxPrice,
      clearPrice: minPrice == null || maxPrice == null,
      page: 0,
    );
    await _search(refresh: true);
  }

  Future<void> resetFilters() async {
    _query = EventQuery(keyword: _query.keyword);
    await _search(refresh: true);
  }

  Future<void> loadMore() => _search(refresh: false);

  Future<void> refresh() => _search(refresh: true);

  Future<void> _search({required bool refresh}) async {
    if (state.isLoadingMore || (!refresh && !state.hasMore)) return;
    final requestId = ++_requestId;
    final nextPage = refresh ? 0 : state.page + 1;

    emit(
      state.copyWith(
        status: state.events.isEmpty || refresh
            ? SearchStatus.loading
            : state.status,
        isLoadingMore: !refresh,
        errorMessage: '',
      ),
    );

    try {
      final result = await _repository.getEvents(
        _query.copyWith(page: nextPage),
      );
      if (requestId != _requestId) return;
      emit(
        state.copyWith(
          status: SearchStatus.success,
          events: refresh ? result.events : [...state.events, ...result.events],
          page: result.page,
          hasMore: result.hasMore,
          isLoadingMore: false,
        ),
      );
    } on AppFailure catch (failure) {
      if (requestId != _requestId) return;
      emit(
        state.copyWith(
          status: state.events.isEmpty
              ? SearchStatus.failure
              : SearchStatus.success,
          isLoadingMore: false,
          errorMessage: failure.message,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

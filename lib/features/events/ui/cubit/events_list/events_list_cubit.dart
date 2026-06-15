import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/app_failure.dart';
import '../../../data/entities/event_entity.dart';
import '../../../data/entities/event_query.dart';
import '../../../data/repos/events_repository.dart';

part 'events_list_state.dart';

class EventsListCubit extends Cubit<EventsListState> {
  EventsListCubit(this._repository, {required EventListMode mode})
    : _query = EventQuery(mode: mode),
      super(EventsListState(mode: mode));

  final EventsRepository _repository;
  EventQuery _query;

  Future<void> load({bool refresh = false}) async {
    if (state.isLoadingMore ||
        (!refresh && state.status == ListStatus.loading)) {
      return;
    }
    final nextPage = refresh
        ? 0
        : state.events.isEmpty
        ? 0
        : state.page + 1;
    if (!refresh && state.events.isNotEmpty && !state.hasMore) return;

    emit(
      state.copyWith(
        status: state.events.isEmpty ? ListStatus.loading : state.status,
        isLoadingMore: state.events.isNotEmpty,
        errorMessage: '',
      ),
    );

    try {
      final result = await _repository.getEvents(
        _query.copyWith(page: nextPage),
      );
      emit(
        state.copyWith(
          status: ListStatus.success,
          events: nextPage == 0
              ? result.events
              : [...state.events, ...result.events],
          page: result.page,
          hasMore: result.hasMore,
          isLoadingMore: false,
        ),
      );
    } on AppFailure catch (failure) {
      emit(
        state.copyWith(
          status: state.events.isEmpty
              ? ListStatus.failure
              : ListStatus.success,
          isLoadingMore: false,
          errorMessage: failure.message,
        ),
      );
    }
  }

  Future<void> changeMode(EventListMode mode) async {
    _query = EventQuery(mode: mode);
    emit(EventsListState(mode: mode));
    await load(refresh: true);
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failure_guard.dart';
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
    switch (state.isLoadingMore ||
        (!refresh && state.status == ListStatus.loading)) {
      case true:
        return;
      case false:
    }
    final nextPage = refresh
        ? 0
        : state.events.isEmpty
        ? 0
        : state.page + 1;
    switch (!refresh && state.events.isNotEmpty && !state.hasMore) {
      case true:
        return;
      case false:
    }

    emit(
      state.copyWith(
        status: state.events.isEmpty ? ListStatus.loading : state.status,
        isLoadingMore: state.events.isNotEmpty,
        errorMessage: '',
      ),
    );

    await FailureGuard.handle(
      () => _repository.getEvents(_query.copyWith(page: nextPage)),
      onSuccess: (page) {
        emit(
          state.copyWith(
            status: ListStatus.success,
            events: nextPage == 0
                ? page.events
                : [...state.events, ...page.events],
            page: page.page,
            hasMore: page.hasMore,
            isLoadingMore: false,
          ),
        );
      },
      onFailure: (failure) {
        emit(
          state.copyWith(
            isLoadingMore: false,
            status: state.events.isEmpty
                ? ListStatus.failure
                : ListStatus.success,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  Future<void> changeMode(EventListMode mode) async {
    _query = EventQuery(mode: mode);
    emit(EventsListState(mode: mode));
    await load(refresh: true);
  }
}
